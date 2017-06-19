# Rails commad
## 1. Create new project
$ rails new hello_app
## 2. Install gemfile
$bundle install --without product 
## 3. Db migrate
$ rails db:migrate
## 4. Generate controller
$ rails generate controller StaticPages home help
## 5. Generate model
$ rails generate model User name:string email:string
## 6. Generate 


# [List of techniqes are Rails Advance]			
# [Rails Advance 1]
## 1. Nested Attribute (fields_for, reject_if, allow_destroy, ...)
	#Cho phép lưu thuộc tính của bản ghi này thông qua bản ghi khác
	class Lesson < ActiveRecord::Base
		has_many :results
		accepts_nested_attributes_for :results, allow_destroy: true, 
		reject_if: proc { |attributes| attributes[:answer_id].blank? }
	end

	#Có thể truyền thuộc tính của results vao lesson
	def member_params
		params.require(:lesson).permit :name, results_attributes:
		[:id, :answer_id]
	end

## 2. Batch Update
#find_each:

	#Each individual record will be sent into block
	User.find_each do |user|
	  #do smt with each user
	  user.do_smt
	end
	
#find_in_batches:

	#Each batch of record(default 1000 records) will be sent into block
	User.find_in_batches do |user|
	  #do smt with each user
	  user.do_smt
	end

#find_each lấy ra các records theo từng batch(khối) sau đó gọi tới từng record trong khối như là một đối tượng riêng. Quá trình này được lặp đi lặp lại cho tới khi tất cả các record được xử lý xong.

#find_in_batches tương tự như find_each khi cũng lấy ra batch các records. Điểm khác biệt ở đây là gọi tới các batches đưa vào trong block dưới dạng một mảng các record thay vì đưa lần lượt từng record vào

#in_batches():

	#in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil)
	Person.in_batches.each do |relation|
		relation.update_all('age = age + 1')
		relation.where('age > 21').update_all(should_party: true)
		relation.where('age <= 21').delete_all
	end
## 3. Form_for & Form_tag
	# phương thức tạo ra một form cho phép người dùng có thể create hoặc update các thuộc tính của một model object cụ thể
	# https://viblo.asia/DuyTran/posts/924lJXBXKPM#
	form_for @user do |f|
		f.text_field :first_name,  id: "abc", class: "abc"
		f.email_field :email
		f.password_field :password
		f.submit "Create my account", class: "btn btn-primary"
	# form_tag ko kết nối trực tiếp tới bất kỳ model nào.
	form_tag "/users", method: :get do
		text_field_tag "subject"
		select_tag("priority", options_for_select([["Critical", "1"], ["Important", "2"],["Standard","3"]], "3"))
		text_area_tag "description", "", :size=>"50x20"
		file_field_tag "attachment"
		submit_tag "Submit"	
## 4. Call back function
	#Callback là các phương thức/hàm được gọi trước hoặc sau khi có sự thay đổi trạng thái (như tạo, lưu, xóa, cập nhật, validate…) của đối tượng.
	#Cách khai báo bình thường:
		#Model
		class Topic < ActiveRecord::Base
			before_destroy :destroy_author
			private
			def destroy_author
	  #...
	end
end
	#Cách khai báo qua block
	class Topic < ActiveRecord::Base
		before_destroy do
	  #...
	end
end
# Creating an Object
		# before_validation
		# after_validation
		# before_save
		# around_save
		# before_create
		# around_create
		# after_create
		# after_save
		# after_commit/after_rollback

# Updating an Object
		# before_validation
		# after_validation
		# before_save
		# around_save
		# before_update
		# around_update
		# after_update
		# after_save
		# after_commit/after_rollback

# Destroying an Object
		# before_destroy
		# around_destroy
		# after_destroy
		# after_commit/after_rollback
#VD:
 #======== Controller ========== 
 before_action :init_device, except: [:index, :new, :create]
 after_action :init_dropdown, only: :index

## 5. Macro (generate, rake, spring, ...)

## 6. Ajax (Rails ajax, jQuery ajax)
## 7. Seed
## 8. RESTful (http://www.infoq.com/articles/rest-introduction) == REpresentational State Transfer
# 	Trong HTTP có các phương thức chuẩn gọi là verb:
# 	GET: Truy cập dữ liệu
# 	POST: Tạo ra dữ liệu mới
# 	PUT: Cập nhật dữ liệu
# 	DELETE: Xóa dữ liệu
# 	Rails hỗ trợ tạo routes theo chuẩn RESTful thông qua phương thức resource
# VD:
# resources :users
# Khi chạy lệnh rails routes ở Terminal sẽ hiện ra:

$ rails routes
    Prefix Verb   URI Pattern           Controller#Action
user_index GET    /user/index(.:format) user#index
 new_users GET    /users/new(.:format)  users#new
edit_users GET    /users/edit(.:format) users#edit
     users GET    /users(.:format)      users#show
           PATCH  /users(.:format)      users#update
           PUT    /users(.:format)      users#update
           DELETE /users(.:format)      users#destroy
           POST   /users(.:format)      users#create
# Trong đó: có 3 phương thức GET dùng để lấy form tạo user mới, lấy form sửa thông tin user và hiện lên user, còn lại là 4 phương thức PATCH, PUT, DELETE và POST
# Chú ý: PUT và PATCH cùng dùng để update nhưng PUT là cập nhật tất cả các thuộc tính của user, còn PATCH là chỉ cập nhập những thuộc tính được thay đổi của user đó.


## 9. Association (has_many/has_one/belongs_to)
	# Rails hỗ trợ 6 kiểu associations:
		# belongs_to
		# has_one
		# has_many
		# has_many :through
		# has_one :through
		# has_and_belongs_to_many

	# Sử dụng belongs_to để thiết lập liên kết one-to-one với một model khác.
	class Customers < ActiveRecord::Base
    	has_many :order # 1-n
    	has_one :order # 1-1
    end

    class Order < ActiveRecord::Base
    	belongs_to :customer
      # Cách viết belongs_to định nghĩa ở trên có nghĩa: các order thuộc duy nhất 1 customer
    end

   # Lien ket n-n
   	# Cach 1: thong qua has_many :through
	   	#app/models/relation.rb
	   	class Relation < ApplicationRecord
	   		belongs_to :category
	   		belongs_to :product
	   	end
			#app/models/category.rb
			class Category < ApplicationRecord
				has_many :relations
				has_many :products, through: :relations
			end
			#app/models/product.rb
			class Product < ApplicationRecord
				has_many :relations
				has_many :categories, through: :relations
			end
		# Cach 2: su dung has_and_belongs_to_many
			#Đây là kiểu quan hệ trực tiếp không có models trung gian

			#app/models/category.rb
			class Category < ApplicationRecord
				has_and_belongs_to_many :products
			end
			#app/models/product.rb
			class Product < ApplicationRecord
				has_and_belongs_to_many :categories
			end

## 10. Transaction
## 11. Resources, Nested Resources
	# Resources tao index action
	# Nested Resources

	class Magazine < ApplicationRecord	#model.rb
		has_many :ads
	end

	class Ad < ApplicationRecord	#model.rb
		belongs_to :magazine
	end

	resources :magazines do 	#routes.rb
		resources :ads
	end

## 12. Resource
	# Resource khong tao index acion
	resources: Index, new, create, show, edit, update, destroy
	resource: 				new, create, show, edit, update, destroy

## 13. Export CSV, Excel
## 14. Rake task
## 15. CSRF Protection
## 16. Coffee
## 17. Concerns

## 18. Scope
class Post < ActiveRecord::Base
	scope :by_status, -> status {where status: status }
	scope :recent, -> {order "posts.updated_at DESC"}
	  # thực hiện truy vấn mỗi lần gọi scope
	end
  # Có thể gọi liên tiếp: 
  Post.by_status(params[:status]).recent
  # SELECT "posts".* FROM "posts" WHERE "posts"."status" = 'published'
	#   ORDER BY posts.updated_at DESC

	# Khác với class method khi input là nil hoặc blank

	# Scope với những truy vấn yêu cầu logic không quá phức tạp hoặc cần sự kết nối nhiều truy vấn với nhau. 
	# Class method sẽ dành cho những công việc yêu cầu độ khó logic nhiều hơn, yêu cầu nhiều tham số đầu vào hơn.
	
	# Mở rộng scope
	scope :page, -> num {  } do
		def per num
		end

		def first_page?
		end

		def last_page?
		end
	end

## 19. I18n (mutil language, dictionary, time format, number format, ...)
## 20. Search form, filter form
## 21. Gem Config (https://github.com/railsconfig/config)
## 22. Eager Loading Associations
class Title < ActiveRecord::Base
	belongs_to :employee
end

class Employee < ActiveRecord::Base
	has_many :titles
end
	#
	employees = Employee.limit(10)
	employees.each do |employee|
		puts employee.title.name
	end
	#Nhìn vào đọc code trên, có vẻ như là ổn, tuy nhiên nếu xét về performance, thì điều đó thật tệ. Cùng xem những câu query đã thực hiện:

	SELECT  `employees`.* FROM `employees` LIMIT 10
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 1 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 2 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 3 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 4 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 5 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 6 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 7 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 8 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 9 LIMIT 1
	SELECT  `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` = 10 LIMIT 1
	# Su dung Eager loading
	employees = Employee.includes(:title).limit(10)
	employees.each do |employee|
		puts employee.title.name
	end
	#Cùng xem những query đã thực hiện:
	SELECT  `employees`.* FROM `employees` LIMIT 10
	SELECT `titles`.* FROM `titles` WHERE `titles`.`deleted_at` IS NULL AND `titles`.`id` IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

## 23. Validation
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validate :email, presence: true, length: {maximum: 255},
format: {with: VALID_EMAIL_REGEX},
           uniqueness: true #ko cho phép tồn tại >1 bản ghi giống nhau
  validate :email, uniqueness: {case_sensitive: false} # khong cho phep luu EMAIL@gmail.com khi da ton tai email@gmail.com         
  add_index :email, unique: true # xu ly truong hop khi co 2 ng cung luu 2 email giong nhau cung 1 luc

## 24. Environment Variable
## 25. MVC
## 26. Module mixin
## 27. Proc / Lambda
## 28. Debug Javascipt code
## 29. Jquery selector
## 30. CSS selector
## 31. Ruby Nil Object
## 32. Delegate
class Candidate < ActiveRecord::Base
	has_one :CandidateDetail
	delegate :artist, to: :CandidateDetail
end
class CandidateDetail < ActiveRecord::Base
	belongs_to :Candidate
end
#thông thường nếu không dùng delegate chúng ta muốn lấy ra trường artist trong model schedule thì ta sẽ phải query:
Candidate.CandidateDetail.artist
# Với delegate ta có thể lấy artist bằng cách :
Candidate.artist

## 33. New & Create
User.create = User.new + User.save

## 34. Gem bcrypt: encoding password
	has_secure_password #model.rb
	# automatically adds an "authenticate" method to the corresponding model objects

## 35. Flash and Flash.now
Flash -> redirect_to
Flash.now -> render

# [Rails Advance 2]
# 1. Gem Devise
# 2. Gem CanCanCan
# 3. Gem Ransack
# 4. Background job: sidekiq, resque
# 5. Cronjob: whenever, delayed job
# 6. Unit Test (Rspec)
# 7. Metaprogramming (send, eval, class_eval, ...)
# 8. Authenticate via Facebook, Twitter, Google
# 9. Social button share (https://github.com/huacnlee/social-share-button)
# 10. Gem paranoia (https://github.com/rubysherpas/paranoia)
# 11. Gem public_activity
# 12. Simple form (https://github.com/plataformatec/simple_form)
# 13. Kaminari (https://github.com/amatsuda/kaminari)
# 14. Friendly_id (https://github.com/norman/friendly_id)
# 15. Chatwork (https://github.com/asonas/chatwork-ruby)

# [Rails Advance 3]
# 1. API
# 2. Haml (https://github.com/haml/haml)
# 3. WebSocket
# 4. Form Object
# 5. Service Object
# 6. Query Object
# 7. Caching 
# 8. Fulltext search
# 9. Pretty URL
# [Evaluation]
# 1. Working days
# 2. Number of task (at least 2 tasks/day)
# 3. Implement with new techniques
# 4. Git
# 5. Rails basic (in tutorial)
# 6. Rails advance
# 7. Coding convention
# 8. Plus
# - Always think how to improve the current code and design more
# - Do not asks basic questions
# - Do not ask the same a problem many times
# - Researches to resolve problems by himself
# - Discusses with others in team
# - Gives actively the idea about problems in team 
# - Discusses in lectures
# - Ask leader about complex task
# - Support others
# - Comment on GitHub


===============================================================================
Cookie 
là 1 đoạn dữ liệu được truyền đến browser từ server, đoạn dữ liệu này sẽ được browser lưu trữ (trong memory hoặc trên đĩa) và sẽ gởi ngược lên lại server mỗi khi browser tải 1 trang web từ server.
Những thông tin được lưu trữ trong cookie hoàn toàn phụ thuộc vào website trên server. Mỗi website có thể lưu trữ những thông tin khác nhau trong cookie, ví dụ thời điểm lần cuối bạn ghé thăm website, đánh dấu bạn đã login hay chưa, v.v...
Cookie được tạo ra bởi website và gởi tới browser, do vậy 2 website khác nhau (cho dù cùng host trên 1 server) sẽ có 2 cookie khác nhau gởi tới browser. Ngoài ra, mỗi browser quản lý và lưu trữ cookie theo cách riêng của mình, cho nên 2 browser cùng truy cập vào 1 website sẽ nhận được 2 cookie khác nhau.

	=> Cookie được sinh ra bởi trình duyệt(máy client)

	Session 
	Là khoảng thời gian người sử dụng giao tiếp với 1 ứng dụng. Session bắt đầu khi người sử dụng truy cập vào ứng dụng lần đầu tiên, và kết thúc khi người sử dụng thoát khỏi ứng dụng. Mỗi session sẽ có một định danh (ID), 1 session khác nhau sẽ có 2 ID khác nhau. Trong ngữ cảnh ứng dụng web, website sẽ quyết định khi nào session bắt đầu và kết thúc.
	Trong 1 session, website có thể lưu trữ một số thông tin như đánh dấu bạn đã login hay chưa, những bài viết nào bạn đã đọc qua, v.v...

	=> Session được sinh ra bởi webserver(máy Server)

	Điểm giống và khác nhau giữa Cookie và Session
	Cookie và Session đều có chung mục đích là lưu giữ data để truyền từ 1 trang web sang 1 trang web khác (trên cùng website). Nhưng phương thức lưu trữ và quản lý data của Cookie và Session có phần khác nhau.
	Cookie sẽ được lưu trữ tại browser, do browser quản lý và browser sẽ tự động truyền cookie ngược lên server mỗi khi truy cập vào 1 trang web trên server.
		Dữ liệu lưu trữ trong Session sẽ được ứng dụng quản lý, trong ngữ cảnh web, ứng dụng ở đây sẽ là website và webserver. Browser chỉ truyền ID của session lên server mỗi khi truy cập vào website trên server.

		Mối liên hệ giữa Session và Cookie: 
		Mỗi Session gắn với 1 định danh (ID). ID sẽ được tạo ra trên server khi session bắt đầu và được truyền cho browser. Sau đó browser sẽ truyền lại ID này lên server mỗi khi truy cập vào website. Như vậy ta có thể thấy rằng sẽ rất tiện nếu như Session ID được lưu trữ trong Cookie và được browser tự động truyền lên server mỗi khi truy cập vào website.

		Sử dụng Cookie hay Session?
		Sử dụng Session hoặc Cookie là tuỳ vào lựa chọn của Lập trình viên, tuy nhiên Session thường được ưa chuộng hơn Cookie vì một số lý do sau:

			*  Trong một số trường hợp Cookie không sử dụng được. Có thể browser đã được thiết lập để không chấp nhận cookie, lúc đó session vẫn sử dụng được bằng cách truyền session ID giữa các trang web qua URL, ví dụ: script.aspx?session=abc123.
			*  Lượng data truyền tải giữa browser và server: chỉ mỗi session ID được truyền giữa browser và server, data thực sự được website lưu trữ trên server.
			*  Bảo mật: càng ít thông tin được truyền tải qua lại giữa browser và client càng tốt, và càng ít thông tin được lưu trữ tại client càng tốt.
