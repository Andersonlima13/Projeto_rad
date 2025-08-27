# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # visitante

    # Regras de autorização:
    can :manage, Account, user_id: user.id
    can :manage, Category, user_id: user.id
    can :manage, Transaction, account: { user_id: user.id }

    # Pode gerenciar a si mesmo (perfil)
    can :manage, User, id: user.id

    # Visitante só pode acessar páginas públicas (se houver)
    cannot :read, Account unless user.persisted?
  end
end
