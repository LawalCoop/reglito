use entity::internal_rules;
use sea_orm_migration::{
    prelude::*,
    sea_orm::{ActiveModelTrait, Set},
};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        let db = manager.get_connection();

        internal_rules::ActiveModel {
            name: Set("internal rule name".to_owned()),
            description: Set("internal rule description".to_owned()),
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
