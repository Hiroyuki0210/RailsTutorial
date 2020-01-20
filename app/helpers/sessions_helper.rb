module SessionsHelper
     # ログイン時にセッションid(ユーザidをcookiesに保存)
     def log_in(user)
          session[:user_id] = user.id
     end
     
     # 現在のユーザをログアウトする
     def log_out
          session.delete(:user_id)
          @current_user = nil
     end

     # 現在ログイン中のユーザを返す
     def current_user
          if session[:user_id]
               @current_user ||= User.find_by(id: session[:user_id])
          end
     end

     # ユーザがログインしている場合はtrue、その他はfalse
     def logged_in?
          ! current_user.nil?
     end
     
end
