json.array!(@codeforces_round_solutions) do |codeforces_round_solution|
  json.extract! codeforces_round_solution, :id
  json.url codeforces_round_solution_url(codeforces_round_solution, format: :json)
end
