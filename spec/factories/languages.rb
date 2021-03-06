FactoryGirl.define do

  factory :language do

    factory :c do
      name 'ANSI C'
      extension 'c'
      ace_mode 'c_cpp'
    end

    factory :cpp do
      name 'cpp'
      extension 'cpp'
      ace_mode 'c_cpp'
    end

    factory :java do
      name 'Java'
      extension 'java'
      ace_mode 'java'
    end

  end
end
