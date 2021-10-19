using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dal
{
    public class DaoLibro : IDaoLibro
    {
        #region Singleton
        private DaoLibro() { }
        private static DaoLibro dao = new DaoLibro();
        public static DaoLibro ObtenerDao()
        {
            return dao;
        }
        #endregion

        public void Borrar(long id)
        {
            using (var db = new Modelo())
            {
                db.Libros.Remove(db.Libros.Find(id));
                db.SaveChanges();
            }
        }

        public Libros Insertar(Libros libro)
        {
            using (var db = new Modelo())
            {
                db.Libros.Add(libro);
                db.Entry(libro).Reference(l => l.Autores).Load();

                db.SaveChanges();
                return libro;
            }
        }

        public Libros Modificar(Libros libro)
        {
            using (var db = new Modelo())
            {
                db.Entry(libro).State = System.Data.Entity.EntityState.Modified;
                db.Entry(libro).Reference(l => l.Autores).Load();
                db.SaveChanges();
                return libro;
            }
        }

        public Libros ObtenerPorId(long id)
        {
            using (var db = new Modelo())
            {
                return db.Libros.Include("Autores").Where(p => p.Id == id).FirstOrDefault();
            }
        }

        public IEnumerable<Libros> ObtenerTodos()
        {
            using (var db = new Modelo())
            {
                return db.Libros.Include("Autores").ToList();
            }
        }

        public IEnumerable<Libros> BuscarPorNombre(string nombre)
        {
            using (var db = new Modelo())
            {
                return db.Libros.Include("Autores").Where(p => p.Nombre.Contains(nombre)).ToList();
            }        
        }
    }
}
