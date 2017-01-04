FactoryGirl.define do
	factory :user do
		sequence (:name) { |n| "Suzy#{n}"}
		password "Secret"
	end

	factory :post do
		title "Example"
		body "Example text"
		user
	end
end

