defmodule Reglito.Chapters do
  alias Reglito.Chapters.Chapter

  def all do
    [
      %Chapter{
        name: "De la cooperativa",
        code: :cooperative,
        description:
          "Aquí pondremos cuestiones generales relacionadas a la normativa a la que está sujeta el reglamento, desde cuando comienza a regir y los principios y valores del trabajo en tu entidad"
      },
      %Chapter{
        name: "De la prestación de servicio",
        code: :services,
        description:
          "Aquí pondremos cuestiones relacionadas a como se organizará internamente la cooperativa, que áreas tendrá, si existirán coordinadores, días y horarios laborables, son cuestiones relacionadas al orden interno de la cooperativa. Según la ley de cooperativas al ser meras cuestiones de organización interna no es necesario inscribirlas en el reglamento interno, pero nosotros sugerimos ponerlas y luego darle la potestad al Consejo de Administración de modificar estos aspectos sin inscribir dichas reformas por no ser obligatorias"
      }
    ]
  end
end
