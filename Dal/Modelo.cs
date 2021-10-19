using Entidades;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace Dal
{
    public partial class Modelo : DbContext
    {
        public Modelo()
            : base("name=Modelo")
        {
            Database.Log = s => System.Diagnostics.Debug.WriteLine(s);
            Configuration.ProxyCreationEnabled = false;
            Configuration.LazyLoadingEnabled = false;
        }

        public virtual DbSet<Autores> Autores { get; set; }
        public virtual DbSet<Libros> Libros { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Autores>()
                .HasMany(e => e.Libros)
                .WithRequired(e => e.Autores)
                .WillCascadeOnDelete(false);
        }
    }
}
