using Dal;
using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApi.Controllers
{
    public class LibrosController : ApiController
    {
        private static readonly IDaoLibro dao = DaoLibro.ObtenerDao();
        // GET: api/Libros
        public IEnumerable<Libros> Get()
        {
            IEnumerable<Libros> libros = dao.ObtenerTodos();
            foreach(var l in libros)
            {
                l.Autores.Libros = null;
            }
            return libros;
        }
        [HttpGet]
        [Route("api/Libros/buscar")]
        public IHttpActionResult Get(string nombre)
        {
            IEnumerable<Libros> libros = dao.BuscarPorNombre(nombre);
            foreach (var l in libros)
            {
                l.Autores.Libros = null;
            }
            if (libros.Count() < 1)
            {
                return NotFound();
            }
            return Ok(libros);
        }

        // GET: api/Libros/5
        public IHttpActionResult Get(long id)
        {
            Libros libro = dao.ObtenerPorId(id);
            if(libro == null)
            {
                return NotFound();
            }
            return Ok(libro);
        }

        // POST: api/Libros
        public IHttpActionResult Post([FromBody]Libros libro)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Content(HttpStatusCode.Created, dao.Insertar(libro));
        }

        // PUT: api/Libros/5
        public IHttpActionResult Put(long id, [FromBody]Libros libro)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (id != libro.Id)
            {
                return BadRequest();
            }
            libro = dao.Modificar(libro);
            return Ok(libro);
        }

        // DELETE: api/Libros/5
        public IHttpActionResult Delete(long id)
        {
            Libros libro = dao.ObtenerPorId(id);
            if (libro == null)
            {
                return NotFound();
            }
            dao.Borrar(id);
            return StatusCode(HttpStatusCode.NoContent);
        }
    }
}
