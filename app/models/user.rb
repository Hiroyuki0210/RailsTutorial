class User < ApplicationRecord
     attr_accessor :remember_token, :activation_token, :reset_token
     before_save :downcase_email
     before_create :create_activation_digest

     VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]/i
     validates :name, presence: true, length: {maximum:30}
     validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
     validates :password, presence: true, length:{minimum: 6}, allow_nil: true

     has_secure_password

     # 渡された文字列のハッシュ値を返す
     def User.digest(string)
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.cost
          BCrypt::Password.create(string, cost: cost)
     end

     # ランダムなトークンを返す
     def User.new_token
          SecureRandom.urlsafe_base64
     end

     # 永続セッションのためユーザをデータベースに記憶する
     def remember
          self.remember_token = User.new_token
          update_attribute(:remember_digest, User.digest(remember_token))
     end

     # 渡されたトークンがダイジェストと一致したらtrueを返す
     def authenticated?(remember_token)
          return false if remember_digest.nil?
          BCrypt::Password.new(remember_digest).is_password?(remember_token)
     end

     # 渡されたトークンがダイジェストと一致したらtrueを返す
     def authenticated?(attribute, token)
          digest = send("#{attribute}_digest")
          return false if digest.nil?
          BCrypt::Password.new(digest).is_password?(token)
     end

     # ユーザのログイン情報を破棄する
     def forget
          update_attribute(:remember_digest, nil)
     end

     # アカウントを有効化する
     def activate
          update_attribute(:activated, true)
          update_attribute(:activated_at, Time.zone.now)
     end

     # 有効化用のメールを送信する
     def send_activation_email
          UserMailer.account_activation(self).deliver_now
     end

     # リセットパスワードのダイジェストを登録
     def create_reset_digest
          self.reset_token = User.new_token
          update_attribute(:reset_digest, User.digest(reset_token))
     end

     # パスワード再設定用のメールを送信、メール送信時間の記録
     def send_reset_password_email
          UserMailer.password_reset(self).deliver_now
          update_attribute(:reset_sent_at, Time.zone.now)
     end

     # パスワードリセットの有効期限が切れている場合はtrueを返す
     def password_reset_expired?
          reset_sent_at < 1.hours.ago
     end

     private
          # メアドを全て小文字にする
          def downcase_email
               self.email = email.downcase
          end

          # 有効化トークンを作成
          def create_activation_digest
               self.activation_token = User.new_token
               self.activation_digest = User.digest(activation_token)
          end

end
