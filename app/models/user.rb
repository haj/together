class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, inverse_of: :user, dependent: :destroy
  has_many :groups, through: :memberships

  def email_domain
    Mail::Address.new(email).domain
  end

  def tenant
    Tenant.where(domain: email_domain).first
  end

  def create_tenant
    unless tenant.present?
      Tenant.create(
        domain: email_domain, 
        schema: Together::SchemaTool.name_for_domain(email_domain))
    end
  end

  def with_tenant_scope_schema &block
    create_tenant

    tenant.scope_schema &block
  end
end