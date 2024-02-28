use sea_orm_migration::prelude::*;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .table(InternalRulesChapterOptions::Table)
                    .if_not_exists()
                    .col(
                        ColumnDef::new(InternalRulesChapterOptions::Id)
                            .integer()
                            .not_null()
                            .auto_increment()
                            .primary_key(),
                    )
                    .col(
                        ColumnDef::new(InternalRulesChapterOptions::Name)
                            .string()
                            .not_null(),
                    )
                    .col(
                        ColumnDef::new(InternalRulesChapterOptions::Description)
                            .string()
                            .not_null(),
                    )
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(
                Table::drop()
                    .table(InternalRulesChapterOptions::Table)
                    .to_owned(),
            )
            .await
    }
}

#[derive(DeriveIden)]
enum InternalRulesChapterOptions {
    Table,
    Id,
    Name,
    Description,
}
