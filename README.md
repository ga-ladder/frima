# frima
## database

### products table
| columnName | type | option|
----|----|----
|name|string|null:false|
|description|text|null:false|
|price|integer|null:false|
|bland_id|integer|null:true index:true|
|category_id|integer|null:false index:true|
|condition|integer|null:false|
|derivery_source|integer|null:false|
|derivery_way|integer|null:false|
|derivery_day|integer|null:false|

_association_
belongs_to :category
belongs_to :brands
has_many :sizes
has_many :likes
has_many :histories
has_many :sales
has_many_attached :images

_中間テーブル_

has_many :product_users
has_many :users, through: :product_users


_condition_

0:新品
1:目立った傷や汚れなし

_delivery_way_

0:本人負担
1:送料込み（出品者負担）

_derivery_day_

0:1~2日以内に発送

1:2~4日以内に発送

2:4~7日以内に発送

### brand table
| columnName | type | option|
----|----|----
|name|string|デフォルトで入力しておく|

_association_

has_many :products

### categories table
| columnName | type | option|
----|----|----
|name|string|
|parent_id|references|

_association_

has_many :subcategories,
class_name: "Category",
foreign_key: "parent_id"

belongs_to :parent, class_name: "Category"

!! デフォルトで入力しておく


### sizes table
| columnName | type | option|
----|----|----
|size|integer|
|product_id|references|

_association_

belongs_to :product


------

### users table
| columnName | type | option|
----|----|----
|nickname|string|
|email|string|devise, unique: true|
|password|string|devise|
|Trackable|string|devise|
|providor|string|omniauth|
|uid|string|omniauth|

_association_

has_one :profile
has_one :resident
has_one :customer

has_many :product_users
has_many :products, through: :product_users

### profiles table
| culumnName | type | option|
----|----|----
|profile|text|

_association_

belongs_to :user

### residents table
| culumnName | type | option|
----|----|----
|realname|string|null:false|
|kananame|string|null:false|
|birthday|datetime|null:false|
|zip_code|integer|null:false|
|prefecture|integer|null:false|
|city_name|string|null:false|
|house_number|string|
|building_name|string|
|phone_number|integer|

_association_
has_one :customer

### customers table
| columnName | type | option|
----|----|----
|customer_id|string|payjp customer|
|user_id|references|

_association_
belongs_to :user

-----

### product_users table(中間テーブル)
| columnName | type | option|
----|----|----
|user_id|references|index :true|
|product_id|references|index :true|

_association_

belongs_to :user
belongs_to :product

### likes
| columnName | type | option|
----|----|----
|product_id|references|index :true|
|user_id|references|index :true|

_association_

belongs_to :user
belongs_to :product

### evaluations table
| columnName | type | option|
----|----|----
|product_id|references|index :true|
|user_id|references|index :true|
|status|integer|null:false|
|comment|text||
_association_
belongs_to :user
belongs_to :product

status(顔文字の部分)
0:笑顔
1:普通
2:困る

### histories table
| columnName | type | option|
----|----|----
|product_id|references|index :true|
|user_id|references|index :true|
|timestamp|

_association_
belongs_to :user
belongs_to :product

### sales table
| culumnName | type | option|
----|----|----
|product_id|references|index:true|
|vendee_id|references||
|vendor_id|references||
|status|integer|pay or repayment|
|charge_id|string|payjp請求id|

_association_
belongs_to :product

-------
