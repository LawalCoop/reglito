# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Reglito.Repo.insert!(%Reglito.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Reglito.Repo

alias Reglito.Chapters.Chapter
alias Reglito.Sections.Section
alias Reglito.Options.Option
alias Reglito.Templates.Template

template_1 = %Template{
  text:
    "ARTÍCULO {ITEM_NUMBER}: La Cooperativa de trabajo CAMPO A COMPLETAR POR EL SISTEMA CON EL NOMBRE DE LA COOPE Ltda. desarrollará sus actividades de acuerdo a la {OPTIONS}"
}

template_2 = %Template{
  text:
    "ARTICULO {ITEM_NUMBER}: El consejo de administración procurará el crecimiento de la entidad, sobre la base de {OPTIONS}. Este reglamento establecerá la manera de organización y funcionamiento de la cooperativa y establecerá la forma de disciplina y control requerido para ésta."
}

options_1 = [
  %Option{
    description: "Ley 20.337"
  },
  %Option{
    description: "Estatuto social"
  },
  %Option{
    description: "Presente reglamento"
  },
  %Option{
    description: "Normas y principios cooperativos"
  },
  %Option{
    description: "Principios de la ACI"
  },
  %Option{
    description: "Principios CICOPA"
  }
]

options_2 = [
  %Option{
    description: "alentar y promover el espíritu de trabajo mancomunado"
  },
  %Option{
    description: "el respeto común y la convivencia solidaria entre las personas asociadas"
  },
  %Option{
    description: "con el fin de crear el medio ideal que permita alcanzar la máxima productividad"
  },
  %Option{
    description: "la ocupación continua de las personas asociadas"
  },
  %Option{
    description:
      "el mantenimiento de la mejor relación con quienes contraten o se relacionen con la cooperativa"
  },
  %Option{
    description: "la constante educación y capacitación de las personas asociadas"
  }
]

sections = [
  %Section{
    name: "¿Bajo qué principios desarrollarán sus actividades?",
    can_select_many: true,
    options: options_1
  },
  %Section{
    name: "¿Bajo que principios procurará el Consejo de Administración hacer su trabajo?",
    can_select_many: true,
    options: options_2
  }
]

chapter = %Chapter{
  name: "De la cooperativa",
  sections: sections
}

Repo.insert!(chapter)

template_1 = %Template{
  text:
    "ARTÍCULO {ITEM_NUMBER}: La cooperativa se distribuirá en las siguientes áreas, {OPTIONS}. El Consejo podrá a su vez, modificar las áreas de la cooperativa así como todo el articulado de esta sección sin necesidad de reforma del reglamento toda vez que son cuestiones de mera organización interna."
}

options_1 = [
  %Option{
    description: "Administración"
  },
  %Option{
    description: "Producción"
  },
  %Option{
    description: "Control de Calidad"
  }
]

sections = [
  %Section{
    name: "Áreas que tendrá la cooperativa",
    can_select_many: true,
    options: options_1
  }
]

chapter = %Chapter{
  name: "De la prestación del servicio",
  sections: sections
}

Repo.insert!(chapter)
