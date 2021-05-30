alter table "public"."budget_item_transactions"
           add constraint "budget_item_transactions_budget_id_fkey"
           foreign key ("budget_id")
           references "public"."budgets"
           ("id") on update restrict on delete restrict;
