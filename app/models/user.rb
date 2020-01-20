class User < ApplicationRecord
     before_save {self.email = email.downcase}

     VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]/i
     validates :name, presence: true, length: {maximum:30}
     validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
     validates :password, presence: true, length:{minimum: 6}

     has_secure_password

     # 渡された文字列のハッシュ値を返す
     def User.digest(string)
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.costBCrypt::Password.create(string, cost: cost)
   end
end
