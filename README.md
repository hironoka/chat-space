# DB design

## messages table

### column
|Column|Type|Restriction|
|:--:|:--:|:--:|
|body|text||
|image|string||
|user_id|integer|null: false|
|group_id|integer|null: false|

### index
- user_id
- group_id

### assosiation
 `belongs_to :user`  
 `belongs_to :group`


## users table

### column
|Column|Type|Restriction|
|:--:|:--:|:--:|
|name|string|null: false|
|email|string|null: false|
|password|integer|null: false|

### index
- email

### assosiation
 `has_many :messages`  
 `has_many :groups, through: :users_groups`
 `has_many :user_groups`


## user_groups table

### column
|Column|Type|Restriction|
|:--:|:--:|:--:|
|user_id|integer|null: false|
|group_id|integer|null: false|

### assosiation
 `belongs_to :user`  
 `belongs_to :group`

### index
 - user_id
 - group_id


## groups table

### column
|Column|Type|Restriction|
|:--:|:--:|:--:|
|name|string|null: false|

### assosiation
`has_many :messages`  
`has_many :users, through: :users_groups`
`has_many :user_groups`
