use entity::chapter::{self, Section, Sections};
use sea_orm_migration::{
    prelude::*,
    sea_orm::{ActiveModelTrait, Set},
};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        let sections_for_coop = vec![
            Section {
                description: "¿Bajo qué principios desarrollarán sus actividades?".to_string(),
                options: vec![
                    "Ley 20.337".to_string(),
                    "Estatuto social".to_string(),
                    "Presente reglamento".to_string(),
                    "Normas y principios cooperativos".to_string(),
                ],
                output: "ARTÍCULO {{CHAPTER}}: La Cooperativa de trabajo {{COOPERATIVE_NAME}}. desarrollará sus actividades de acuerdo a la {{OPTION_SELECTED}}.".to_string()
            },
            Section {
                description: "¿Bajo que principios procurará el Consejo de Administración hacer su trabajo?".to_string(),
                options: vec![
                    "Alentar y promover el espíritu de trabajo mancomunado,".to_string(),
                    "El respeto común y la convivencia solidaria entre las personas asociadas".to_string(),
                    "Con el fin de crear el medio ideal que permita alcanzar la máxima productividad".to_string(),
                ],
                output: "ARTICULO {{CHAPTER}}: El consejo de administración procurará el crecimiento de la entidad, sobre la base de {{OPTION_SELECTED}} Este reglamento establecerá la manera de organización y funcionamiento de la cooperativa y establecerá la forma de disciplina y control requerido para ésta. Este reglamento será de aplicación práctica para la cooperativa una vez que sea aprobado por su Asamblea de personas asociadas e inscripto en el INAES, y permitirá tener un control a fin de mantener el orden y la subordinación a la organización con respecto a los coordinadores escogidos democráticamente por los integrantes de la organización, transformando la realidad existente en una realidad acorde con los alineamientos de la ley de cooperativas 20.337 y sus modificaciones presentes y futuras, así como el Estatuto de la organización.".to_string()
            }
        ];

        let sections_for_coop: Sections = Sections(sections_for_coop);

        let db = manager.get_connection();

        chapter::ActiveModel {
            name: Set("Cooperativa".to_owned()),
            sections: Set(sections_for_coop),
            ..Default::default()
        }
        .insert(db)
        .await?;

        let sections_for_services = vec![
            Section {
                description: "Áreas que tendrá la cooperativa".to_string(),
                options: vec![
                    "Administración".to_string(), 
                    "Producción".to_string(), 
                    "Control de Calidad".to_string(),
                ],
                output: "{{CHAPTER}}: La cooperativa se distribuirá en las siguientes áreas, {{OPTION_SELECTED}}".to_string()
            }
        ];

        let sections_for_services: Sections = Sections(sections_for_services);

        chapter::ActiveModel {
            name: Set("Prestación del servicio".to_owned()),
            sections: Set(sections_for_services),
            ..Default::default()
        }
        .insert(db)
        .await?;

        Ok(())
    }

    async fn down(&self, _manager: &SchemaManager) -> Result<(), DbErr> {
        todo!("")
    }
}
