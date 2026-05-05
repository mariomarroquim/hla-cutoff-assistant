# frozen_string_literal: true

require "sinatra"

get "/" do
  send_file "index.html"
end

get "/version" do
  "2026-05-05"
end

get "/run" do
  response["Access-Control-Allow-Origin"] = "*"

  halt 400, "The MFIs field must be filled with valid numbers." if params[:mfis].nil? || params[:mfis].strip.empty?

  mfis = params[:mfis].strip.split("-").collect(&:to_i)

  halt 400, "The MFIs field must contain at least 5 numbers." if mfis.size < 5

  cutoff = find_cutoff(mfis)

  halt 500, "It was not possible to calculate a MFI cutoff value." if cutoff.nil?

  cutoff.to_s
rescue StandardError
  halt 500, "There is an issue with our service. Please try again later."
end

def find_cutoff(numbers)
  return nil if numbers.empty?

  sorted_numbers = numbers.sort

  cutoff, lowest_variance = nil, Float::INFINITY

  (1...sorted_numbers.size).each do |i|
    left_group = sorted_numbers[0...i]
    right_group = sorted_numbers[i..]

    left_variance = variance(left_group)
    right_variance = variance(right_group)

    total_variance = left_variance + right_variance

    if total_variance < lowest_variance
      cutoff = sorted_numbers[i - 1]
      lowest_variance = total_variance
    end
  end

  index = sorted_numbers.index(cutoff) || -1
  sorted_numbers[index + 1]
end

def variance(group)
  return 0 if group.empty?

  mean = group.sum.to_f / group.size
  group.map { |num| (num - mean) ** 2 }.sum
end
