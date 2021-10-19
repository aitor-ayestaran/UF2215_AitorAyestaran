using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dal
{
    public interface IDaoLibro : IDao<Libros>
    {
        IEnumerable<Libros> BuscarPorNombre(string nombre);
    }
}
