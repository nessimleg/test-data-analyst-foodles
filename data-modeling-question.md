**Can you explain the difference between a fact table and a dimension table ?**

A fact table is a combination of several attributes (identified by foreign keys) that are detailed in different dimension tables. These dimension tables contains a primary key and some details about the dimension : name, description, etc.


**Would you say that the transaction table is a dimension table or a fact table ? Why ?**

Depending on which object we consider, transaction table might be either a fact or a dimension table. If we consider a subvention as a main object, transaction table can be considered as dimension table with the details about each transaction. If we consider a transaction as a main object, it will be a fact table, with some dimension tables such as users (Primary Key = user_id).
