class User < ActiveRecord::Base
    after_save :clear_password

    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i

    def clear_password
        self.password_digest = nil
    end

    def self.authenticate(login_email="", login_password="")
        if  EMAIL_REGEX.match(login_email)    
            user = User.find_by_email(login_email)
        end
        
        if user.password_digest == user.match_password(login_password)
            return user
        else
            return false
        end
    end

    def match_password(login_password="")
       Digest::SHA1.hexdigest (login_password)
    end
end
