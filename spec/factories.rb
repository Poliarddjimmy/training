FactoryBot.define do
    factory :user do
        name { "Poliard Djimmy" }
        username { "Jey13"}
        email {"poliarddjimmy@gmail.com"}
        password { "dfsbsdfbsdfnsj" }
    end

    factory :category do
        name { "The first test category" }
        description { "Some description for the first category"}
    end

    factory :course do
        name {"The first course"}
        description { "Some description for the first course"}
        active {true}
        category {build(:category)}
    end

    factory :requirement do
        price { "" }
        duration { "1000" }
        content { "This is the content for this requirement" }
        course { build(:course) }
    end

    factory :courseUser do
        user { build(:user) }
        course { build(:course) }
    end

    factory :chapter do
        title { " The first chapter "}
        description { "Some description for the first chapter"}
        objective {"Objective for the first chapter"}
        course {build(:course)}
    end

    factory :lesson do
        title { "The first lesson" }
        description { "Some description for the first lesson"}
        content {"Content for the first lesson"}
        chapter {build(:chapter)}
    end

end