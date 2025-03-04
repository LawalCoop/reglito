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
      },
      %Chapter{
        name: "Atribuciones y obligaciones de las personas asociadas",
        code: :power_and_duties,
        description:
          "Aquí se definen con mayor precisión los derechos y obligaciones de quienes forman parte de la cooperativa en base al estatuto modelo del INAES adaptándolo a las particularidades de tu entidad."
      },
      %Chapter{
        name: "Retribuciones periódicas por aportes de trabajo",
        code: :retributions,
        description:
          "En cooperativas de trabajo existen dos tipos de retribuciones, las que se dan periódicamente (algunas cooperativas lo hacen diariamente, otras semanalmente y otras por mes) y las que luego se votan en asamblea con el resultado del ejercicio. Hay cooperativas que tienen distintos criterios para repartirse estos excedentes (se suelen usar casi de manera idéntica las palabras retiro, adelanto de retorno, retribución, adelanto de excedente), por ejemplo pueden fijar categorías con criterios de antigüedad, si la persona tiene hijos/as o no para lo que es períodico y repartir lo anual por partes iguales o por hora trabajada con independencia de la categoría. En esta sección te mostraremos algunos modelos de reparto de retribuciones periódicas y en otro capítulo se aborda la forma de distribución anual.
           Es importante mencionar que por Resolución de INAES, nada de lo que se ponga en este capítulo puede ser inferior al convenio colectivo de trabajo que corresponda a la actividad de la cooperativa para trabajadores con patrón."
      },
      %Chapter{
        name: "Retribuciones anuales que surgen del balance contable",
        code: :balance_retributions,
        description:
          "Como mencionamos en el capítulo anterior, aquí te mostraremos modelos de como se reparte el excedente que surge del balance anual"
      }
      # %Chapter{
      #   name: "De las sanciones",
      #   code: :penalties,
      #   description:
      #     "En este capítulo tendrás modelos del procedimiento a aplicar si alguna persona asociada inclumple sus deberes y obligaciones. La primera parte se refiere a esto y la segunda parte al procedimiento que se debe aplicar en los casos mas graves, a saber suspensiones o exclusiones, este procedimiento se denomina “sumario” y debe seguir ciertas pautas que se describen en este capítulo."
      # },
      # %Chapter{
      #   name: "De las licencias",
      #   code: :licenses,
      #   description:
      #     "En este capítulo te mostramos algunos modelos de artículos sobre licencias en cooperativas de trabajo, al igual que en el de retribuciones periódicas, en este el INAES no aprueba reglamentos que tengan condiciones de trabajo inferiores a la de los trabajadores dependientes de la rama en la que la cooperativa opera.
      #     Aqui podrás ver modelos de artículos para licencias por embarazo, enfermedad, entre otros.
      #     A su vez, incorporamos modelos de artículos de renuncias de personas asociadas por jubilación y/o invalidez."
      # }
    ]
  end

  def by_code do
    Map.new(all(), &{&1.code, &1})
  end
end
