alter table "public"."financial_transactions"
           add constraint "financial_transactions_budget_item_id_fkey"
           foreign key ("budget_item_id")
           references "public"."budget_items"
           ("id") on update restrict on delete restrict;
