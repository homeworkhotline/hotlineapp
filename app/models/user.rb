class User < ApplicationRecord
  
  has_many :time_clocks
  has_many :mnps_reports

	validates :token,
    inclusion: { in: [ "volunteer" , "hotline teacher", "mnps","5h43bf3ff2azce43"] }

  validates :username, :firstname, :lastname, :email, :token,
    presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:studentvol, :hotlineteacher, :teacher, :admin]
end
