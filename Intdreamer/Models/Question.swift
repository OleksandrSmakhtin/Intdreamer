//
//  Question.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 11/09/2023.
//

import Foundation


struct Question {
    let question: String
    let options: [String]
    let answer: [String]
}

class Questions {
    static let shared = Questions()
    
    
    func getQuestion(for index: Int) -> Question {
        switch index {
        case 0:
            return getFirstQuestion()
        case 1:
            return getSecondQuestion()
        case 2:
            return getThirdQuestion()
        case 3:
            return getFourthQuestion()
        case 4:
            return getFifthQuestion()
        default:
            return Question(question: "", options: [], answer: [])
        }
    }
    
    
    private func getFirstQuestion() -> Question {
        let options = [
            "Excellent",
            "Good",
            "Average",
            "Poor",
            "Very Poor"
        ]
        let answers = [
            "You had a deep and uninterrupted sleep, woke up feeling refreshed and energized, and experienced no disturbances during the night.",
            "You had a generally restful night with minor disturbances, but you still woke up feeling reasonably refreshed and ready for the day.",
            "Your sleep had some disruptions, perhaps due to occasional awakenings, noise, or discomfort, leaving you feeling moderately rested.",
            "You had a restless night with frequent awakenings, discomfort, or other issues that significantly affected your sleep quality, and you woke up feeling tired.",
            "You had an extremely disrupted and uncomfortable night's sleep, perhaps experiencing severe insomnia, nightmares, or other sleep disturbances, and you woke up feeling extremely fatigued and unrested."
        ]
        return Question(question: "How would you rate the quality of your sleep last night?", options: options, answer: answers)
    }
    
    private func getSecondQuestion() -> Question {
        let options = [
            "Yes, I have a bedtime routine.",
            "I reflect on my day.",
            "I journal my thoughts.",
            "I meditate or do deep breathing.",
            "I avoid screens before bed."
        ]
        let answers = [
            "You have a consistent and structured routine that you follow before going to bed. This routine may include activities such as brushing your teeth, reading a book, or taking a warm bath. Having a bedtime routine can promote better sleep hygiene and signal to your body that it's time to wind down for the night.",
            "Before going to bed, you take some time to think about and mentally process your day. This reflection can help you clear your mind of any lingering thoughts or concerns, which may contribute to a more peaceful sleep.",
            "You engage in a practice of writing down your thoughts, emotions, or concerns in a journal before bedtime. This can be a helpful way to unload your mind and address any worries or anxieties, potentially leading to a more relaxed and restful sleep.",
            "You incorporate relaxation techniques such as meditation or deep breathing exercises into your pre-sleep routine. These practices can help calm your mind and reduce stress, making it easier to fall asleep peacefully.",
            "You consciously limit your exposure to screens (such as smartphones, tablets, or computers) before bedtime. This is a good habit because the blue light emitted by screens can interfere with your circadian rhythm and make it harder to fall asleep. Avoiding screens can promote better sleep quality."
        ]
        return Question(question: "Did you follow a specific bedtime routine or have any thoughts or concerns before going to bed?", options: options, answer: answers)
    }
    
    private func getThirdQuestion() -> Question {
        let options = [
            "Energized and refreshed",
            "Neutral",
            "Tired, but okay",
            "Very tired and groggy",
        ]
        let answers = [
            "You woke up feeling full of energy and refreshed, ready to take on the day ahead. This suggests that you had a restful and rejuvenating night's sleep.",
            "You woke up feeling neither particularly energized nor tired. You may not have experienced a remarkable change in your energy levels upon waking.",
            "You woke up feeling somewhat tired, but it's a manageable level of fatigue. You might need some time to fully wake up and get going, but you're not overly groggy.",
            "You woke up feeling extremely tired and groggy, which can make it difficult to get out of bed and start your day. This suggests that your sleep quality may have been suboptimal, or you might not have gotten enough sleep."
        ]
        return Question(question: "How did you feel after waking up?", options: options, answer: answers)
    }
    
    private func getFourthQuestion() -> Question {
        let options = [
            "Yes, I often have emotions in my dreams.",
            "Emotions vary in my dreams.",
            "Dreams can evoke different feelings.",
            "I experience emotions during some dreams.",
            "Yes, I feel things in my dreams."
        ]
        let answers = [
            "You frequently experience strong emotions or feelings while dreaming. These emotions could range from happiness and excitement to fear, sadness, or anxiety. Having emotionally charged dreams is quite common and can be influenced by various factors in your life.",
            "Emotions in your dreams are diverse and may not follow a specific pattern. Some dreams may evoke strong emotions, while others may be more neutral or mixed in terms of feelings.",
            "You recognize that your dreams can elicit a wide range of emotions and feelings. This suggests that your dream experiences are dynamic and can encompass a broad spectrum of emotional states.",
            "Emotions are present in certain dreams you have, but not necessarily in all of them. Some dreams may evoke strong feelings, while others may be less emotionally charged.",
            "You have a sensory and emotional experience within your dreams, suggesting that your dream world feels vivid and real, and you are connected to the emotional aspects of your dream scenarios."
        ]
        return Question(question: "Did you experience any emotions or feelings during your dream(s)?", options: options, answer: answers)
    }
    
    private func getFifthQuestion() -> Question {
        let options = [
            "I dreamt of flying last night, which made me feel exhilarated.",
            "In my dream, I was in a forest, feeling both lost and curious.",
            "I had a dream about an old friend, and it left me feeling nostalgic.",
            "Last night's dream had a mysterious door that piqued my interest.",
            "I can recall a dream about a storm, which made me feel anxious."
        ]
        let answers = [
            "Your dream involved the sensation of flying, and it left you feeling excited and full of exhilaration. Flying dreams can symbolize a sense of freedom or empowerment.",
            "You found yourself in a dream within a forest, and it was characterized by a mix of emotions—feeling both lost and curious. The forest can symbolize exploration and the unknown, while these emotions suggest a sense of adventure and uncertainty.",
            "Your dream featured an old friend, and it triggered feelings of nostalgia. Dreams about familiar people from the past often bring up emotions associated with past experiences and relationships.",
            "Your dream included a mysterious door that captured your curiosity. Dreams involving intriguing symbols like mysterious doors can symbolize opportunities, transitions, or the unknown.",
            "You dreamt about a storm, and it evoked feelings of anxiety. Weather-related dreams, like storms, can be linked to emotional turbulence or uncertainty in your waking life."
        ]
        return Question(question: "Briefly describe any dreams you can recall from last night. Include any emotions, or symbols that stood out to you.", options: options, answer: answers)
    }
}
