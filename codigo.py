import customtkinter as ctk
from tkinter import ttk, messagebox
import mysql.connector
from mysql.connector import Error

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")

class ProyectoApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Gestión Total - Base de Datos")
        self.geometry("1150x700")

        self.grid_columnconfigure(1, weight=1)
        self.grid_rowconfigure(0, weight=1)

        # --- MENU LATERAL ---
        self.sidebar = ctk.CTkFrame(self, width=220, corner_radius=0)
        self.sidebar.grid(row=0, column=0, sticky="nsew")
        
        ctk.CTkLabel(self.sidebar, text="MENÚ", font=("Arial", 22, "bold")).pack(pady=20)

        # Módulos
        self.crear_boton("📦 Productos", "producto")
        self.crear_boton("🏪 Tiendas", "tienda")
        self.crear_boton("👥 Clientes", "usuario")
        self.crear_boton("📝 Pedidos", "pedido")
        self.crear_boton("👔 Empleados", "empleado")

        # --- CONTENIDO CENTRAL ---
        self.content = ctk.CTkFrame(self)
        self.content.grid(row=0, column=1, padx=20, pady=20, sticky="nsew")
        
        self.lbl_titulo = ctk.CTkLabel(self.content, text="Seleccione un módulo", font=("Arial", 22, "bold"))
        self.lbl_titulo.pack(pady=15)

        # Botones de Acción (INTERFAZ COMPLETA)
        self.acciones = ctk.CTkFrame(self.content, fg_color="transparent")
        self.acciones.pack(fill="x", padx=20, pady=10)

        self.btn_add = ctk.CTkButton(self.acciones, text="➕ Agregar", fg_color="#2ECC71", hover_color="#27AE60", command=self.abrir_formulario_agregar)
        self.btn_add.pack(side="left", padx=5)

        self.btn_edit = ctk.CTkButton(self.acciones, text="✏️ Modificar", fg_color="#F39C12", hover_color="#D68910", command=self.abrir_formulario_modificar)
        self.btn_edit.pack(side="left", padx=5)

        self.btn_del = ctk.CTkButton(self.acciones, text="🗑 Eliminar", fg_color="#E74C3C", hover_color="#C0392B", command=self.eliminar_dato)
        self.btn_del.pack(side="left", padx=5)

        # Tabla con Scrollbars
        self.frame_tabla = ctk.CTkFrame(self.content)
        self.frame_tabla.pack(expand=True, fill="both", padx=20, pady=10)

        self.scroll_y = ttk.Scrollbar(self.frame_tabla, orient="vertical")
        self.scroll_x = ttk.Scrollbar(self.frame_tabla, orient="horizontal")
        
        self.tree = ttk.Treeview(self.frame_tabla, show="headings", yscrollcommand=self.scroll_y.set, xscrollcommand=self.scroll_x.set)
        
        self.scroll_y.pack(side="right", fill="y")
        self.scroll_x.pack(side="bottom", fill="x")
        self.scroll_y.config(command=self.tree.yview)
        self.scroll_x.config(command=self.tree.xview)
        self.tree.pack(expand=True, fill="both")
        
        self.tabla_actual = ""

    def crear_boton(self, texto, tabla):
        ctk.CTkButton(self.sidebar, text=texto, anchor="w", command=lambda: self.cargar_datos(tabla)).pack(pady=5, padx=20, fill="x")

    def conectar(self):
        return mysql.connector.connect(host="127.0.0.1", user="root", password="", database="proyecto")

    def cargar_datos(self, tabla):
        self.tabla_actual = tabla
        self.lbl_titulo.configure(text=f"Gestión de {tabla.upper()}")
        try:
            conn = self.conectar()
            cursor = conn.cursor()
            cursor.execute(f"SELECT * FROM {tabla}")
            cols = [desc[0] for desc in cursor.description]
            rows = cursor.fetchall()

            self.tree.delete(*self.tree.get_children())
            self.tree["columns"] = cols
            for c in cols:
                self.tree.heading(c, text=c.replace("_", " ").upper())
                self.tree.column(c, width=120, minwidth=100)
            for r in rows:
                self.tree.insert("", "end", values=r)
        except Error as e:
            messagebox.showerror("Error", f"Error al cargar: {e}")
        finally:
            if 'conn' in locals() and conn.is_connected():
                conn.close()

    def eliminar_dato(self):
        seleccion = self.tree.selection()
        if not seleccion:
            messagebox.showwarning("Aviso", "Selecciona una fila primero")
            return

        try:
            conn = self.conectar()
            cursor = conn.cursor()
            cursor.execute(f"SHOW KEYS FROM {self.tabla_actual} WHERE Key_name = 'PRIMARY'")
            pk_columna = cursor.fetchone()[4] 

            indice_columna = self.tree["columns"].index(pk_columna)
            id_valor = self.tree.item(seleccion)['values'][indice_columna]

            if messagebox.askyesno("Confirmar", f"¿Estás seguro de borrar el registro con {pk_columna.upper()}: {id_valor}?"):
                cursor.execute(f"DELETE FROM {self.tabla_actual} WHERE {pk_columna} = %s", (id_valor,))
                conn.commit()
                messagebox.showinfo("Éxito", "Eliminado correctamente")
                self.cargar_datos(self.tabla_actual)
                
        except Error as e:
            messagebox.showerror("No se puede eliminar", f"Este registro está en uso en otra tabla.\n\nError: {e}")
        finally:
            if 'conn' in locals() and conn.is_connected():
                conn.close()

    def abrir_formulario_agregar(self):
        if not self.tabla_actual:
            messagebox.showwarning("Aviso", "Primero selecciona un módulo a la izquierda")
            return
        
        ventana = ctk.CTkToplevel(self)
        ventana.title(f"Añadir a {self.tabla_actual.upper()}")
        ventana.geometry("450x550")
        ventana.attributes("-topmost", True)

        ctk.CTkLabel(ventana, text=f"NUEVO: {self.tabla_actual.upper()}", font=("Arial", 18, "bold")).pack(pady=15)

        scroll_form = ctk.CTkScrollableFrame(ventana, width=400, height=400)
        scroll_form.pack(pady=10, padx=10, fill="both", expand=True)

        entradas = {}
        try:
            conn = self.conectar()
            cursor = conn.cursor()
            cursor.execute(f"DESCRIBE {self.tabla_actual}")
            columnas = cursor.fetchall()
            
            for col in columnas:
                nombre_col = col[0]
                ctk.CTkLabel(scroll_form, text=nombre_col.replace("_", " ").title() + ":").pack(anchor="w", padx=20, pady=(10,0))
                e = ctk.CTkEntry(scroll_form, width=350)
                e.pack(padx=20, pady=2)
                entradas[nombre_col] = e
        except Error as e:
            messagebox.showerror("Error", str(e))
            return
        finally:
            conn.close()

        def guardar():
            columnas_nombres = ", ".join(entradas.keys())
            placeholders = ", ".join(["%s"] * len(entradas))
            valores = [e.get() if e.get() != "" else None for e in entradas.values()]
            
            try:
                conn_g = self.conectar()
                cursor_g = conn_g.cursor()
                cursor_g.execute(f"INSERT INTO {self.tabla_actual} ({columnas_nombres}) VALUES ({placeholders})", valores)
                conn_g.commit()
                messagebox.showinfo("Éxito", "Guardado exitosamente")
                ventana.destroy()
                self.cargar_datos(self.tabla_actual)
            except Error as e:
                messagebox.showerror("Error", f"Error al guardar: {e}")
            finally:
                if 'conn_g' in locals() and conn_g.is_connected():
                    conn_g.close()

        ctk.CTkButton(ventana, text="✔ GUARDAR NUEVO", fg_color="#2ECC71", hover_color="#27AE60", command=guardar).pack(pady=15)

    def abrir_formulario_modificar(self):
        seleccion = self.tree.selection()
        if not seleccion:
            messagebox.showwarning("Aviso", "Selecciona la fila que deseas modificar")
            return

        ventana = ctk.CTkToplevel(self)
        ventana.title(f"Modificar {self.tabla_actual.upper()}")
        ventana.geometry("450x550")
        ventana.attributes("-topmost", True)

        ctk.CTkLabel(ventana, text=f"MODIFICAR: {self.tabla_actual.upper()}", font=("Arial", 18, "bold")).pack(pady=15)

        scroll_form = ctk.CTkScrollableFrame(ventana, width=400, height=400)
        scroll_form.pack(pady=10, padx=10, fill="both", expand=True)

        valores_actuales = self.tree.item(seleccion)['values']
        columnas_nombres = self.tree["columns"]
        entradas = {}
        
        try:
            conn = self.conectar()
            cursor = conn.cursor()
            cursor.execute(f"SHOW KEYS FROM {self.tabla_actual} WHERE Key_name = 'PRIMARY'")
            pk_columna = cursor.fetchone()[4]
        except Exception:
            pk_columna = columnas_nombres[0] # Por defecto usa la primera si falla
        finally:
            if 'conn' in locals() and conn.is_connected():
                conn.close()

        pk_valor = None

        # Crear los campos y rellenarlos con los datos actuales
        for i, col in enumerate(columnas_nombres):
            ctk.CTkLabel(scroll_form, text=col.replace("_", " ").title() + ":").pack(anchor="w", padx=20, pady=(10,0))
            e = ctk.CTkEntry(scroll_form, width=350)
            e.pack(padx=20, pady=2)
            
            # Poner el texto actual en la caja
            valor_texto = str(valores_actuales[i]) if valores_actuales[i] is not None and valores_actuales[i] != "None" else ""
            e.insert(0, valor_texto)
            
            if col == pk_columna:
                e.configure(state="disabled") # Bloquear la Llave Primaria (No se puede editar el ID/NIT/Cedula)
                pk_valor = valores_actuales[i]
            else:
                entradas[col] = e

        def guardar_cambios():
            # Construir consulta UPDATE tabla SET col1=%s, col2=%s WHERE id=%s
            set_clause = ", ".join([f"{col}=%s" for col in entradas.keys()])
            valores = [e.get() if e.get() != "" else None for e in entradas.values()]
            valores.append(pk_valor) # Añadir el valor de la PK para el WHERE
            
            try:
                conn_g = self.conectar()
                cursor_g = conn_g.cursor()
                cursor_g.execute(f"UPDATE {self.tabla_actual} SET {set_clause} WHERE {pk_columna} = %s", valores)
                conn_g.commit()
                messagebox.showinfo("Éxito", "Registro modificado correctamente")
                ventana.destroy()
                self.cargar_datos(self.tabla_actual)
            except Error as e:
                messagebox.showerror("Error", f"Error al modificar: {e}")
            finally:
                if 'conn_g' in locals() and conn_g.is_connected():
                    conn_g.close()

        ctk.CTkButton(ventana, text="💾 GUARDAR CAMBIOS", fg_color="#F39C12", hover_color="#D68910", command=guardar_cambios).pack(pady=15)

if __name__ == "__main__":
    app = ProyectoApp()
    app.mainloop()