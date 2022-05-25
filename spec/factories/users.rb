# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user, class: User do
    uuid { SecureRandom.uuid }
    email { Faker::Internet.email }

    trait(:blocked) do
      blocked { true }
    end

    to_create(&:save)
  end
end
