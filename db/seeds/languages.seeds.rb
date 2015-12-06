puts 'Adding Languages.....'

Language.create!(name: 'Java', extension: 'java', ace_mode: 'java')
Language.create!(name: 'cpp', extension: 'cpp', ace_mode: 'c_cpp')
Language.create!(name: 'ANSI C', extension: 'c', ace_mode: 'c_cpp')
Language.create!(name: 'Python', extension: 'py', ace_mode: 'python')
Language.create!(name: 'Ruby', extension: 'rb', ace_mode: 'ruby')
Language.create!(name: 'Javascript', extension: 'js', ace_mode: 'ace_mode: ruby')
Language.create!(name: 'Other', extension: '*', ace_mode: 'plain_text')

puts 'Language set added!'
