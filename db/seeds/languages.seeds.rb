puts 'Adding Languages.....'

Language.create!(name: 'Java', extension: 'java')
Language.create!(name: 'cpp', extension: 'cpp')
Language.create!(name: 'Ansi C', extension: 'c')
Language.create!(name: 'Python', extension: 'py')
Language.create!(name: 'Ruby', extension: 'rb')
Language.create!(name: 'Other', extension: 'txt')

puts 'Language set added!'