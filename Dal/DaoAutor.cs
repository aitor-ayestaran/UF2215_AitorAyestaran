using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dal
{
    public class DaoAutor : IDao<Autores>
    {
        #region Singleton
        private DaoAutor() { }
        private static DaoAutor dao = new DaoAutor();
        public static DaoAutor ObtenerDao()
        {
            return dao;
        }
        #endregion
        public void Borrar(long id)
        {
            using (var db = new Modelo())
            {
                db.Autores.Remove(db.Autores.Find(id));
                db.SaveChanges();
            }
        }

        public Autores Insertar(Autores autor)
        {
            using (var db = new Modelo())
            {
                db.Autores.Add(autor);
                db.SaveChanges();
                return autor;
            }
        }

        public Autores Modificar(Autores autor)
        {
            using (var db = new Modelo())
            {
                db.Entry(autor).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return autor;
            }
        }

        public Autores ObtenerPorId(long id)
        {
            using (var db = new Modelo())
            {
                return db.Autores.Include("Libros").Where(a => a.Id == id).FirstOrDefault();
            }
        }

        public IEnumerable<Autores> ObtenerTodos()
        {
            using (var db = new Modelo())
            {
                return db.Autores.ToList();
            }
        }
    }
}
