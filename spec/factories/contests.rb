FactoryGirl.define do
  factory :contest do

    factory :uva do
      name 'UVa Online Judge'
      url 'https://uva.onlinejudge.org/'
      description 'UVa Online Judge.'
    end

    factory :topcoder do
      name 'TopCoder'
      url 'http://www.topcoder.com'
      description 'A vendor-neutral coding competition site'
    end

    factory :codeforces do
      name 'Codeforces'
      url 'http://codeforces.com'
      description 'The only programming contests on Web 2.0 platform.'
    end

  end
end
