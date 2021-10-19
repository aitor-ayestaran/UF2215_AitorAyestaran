namespace Entidades
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Libros
    {
        public long Id { get; set; }

        [Required]
        [StringLength(50)]
        public string Nombre { get; set; }

        public long AutoresId { get; set; }

        public virtual Autores Autores { get; set; }
    }
}
