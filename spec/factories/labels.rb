FactoryBot.define do
  factory :label do
    label_name { "label1" }
  end
  factory :second_label, class: Label do
    label_name { "label2" }
  end

  factory :third_label, class: Label do
    label_name { "label3" }
  end
end
