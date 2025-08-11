
//
//  Restaurant.swift
//  Restaurant
//
//  Created by Den on 5/20/24.
//

import Foundation

struct Restaurant {
    let image: String
    let latitude: Double
    let longitude: Double
    let name: String
    let address: String
    let phoneNumber: String
    let category: String
    let price: Int
    let type: Int
}

struct RestaurantList {
    
    private init() { }
    
    static let restaurantArray: [Restaurant] = [
        Restaurant(
            image: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=600&auto=format&fit=crop&q=60", // 콩나물국밥
            latitude: 37.514746,
            longitude: 126.898935,
            name: "24시전주명가콩나물국밥 문래점",
            address: "서울 영등포구 선유로 33 문래대림아파트",
            phoneNumber: "02-2677-6339",
            category: "한식",
            price: 5000,
            type: 300
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1547573854-74d2a71d0826?w=600&auto=format&fit=crop&q=60", // 뷔페/한식
            latitude: 37.516107,
            longitude: 126.886853,
            name: "데일리 푸드",
            address: "서울 영등포구 선유로3길 10 하우스디비즈 지하1층 B101호",
            phoneNumber: "02-2675-7462",
            category: "한식",
            price: 1000,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=600&auto=format&fit=crop&q=60", // 셀프서비스
            latitude: 37.518996,
            longitude: 126.885964,
            name: "에이스한식셀프",
            address: "서울 영등포구 선유로13길 25",
            phoneNumber: "02-2257-8338",
            category: "한식",
            price: 5000000,
            type: 200
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&auto=format&fit=crop&q=60", // 베이글/카페
            latitude: 37.517597,
            longitude: 126.887247,
            name: "쉬즈베이글 문래점",
            address: "서울 영등포구 선유로9길 10 SK V1 center 1층 109",
            phoneNumber: "0507-877-3884",
            category: "카페",
            price: 98564200,
            type: 200
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1547573854-74d2a71d0826?w=600&auto=format&fit=crop&q=60", // 순대국/감자탕
            latitude: 37.517801,
            longitude: 126.887159,
            name: "탐라순대국감자탕 문래점",
            address: "서울 영등포구 선유로9길 10 1층",
            phoneNumber: "0507-1345-3738",
            category: "한식",
            price: 10,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1545006726-75683084db6a?w=600&auto=format&fit=crop&q=60", // 짬뽕/중식
            latitude: 37.516912,
            longitude: 126.888908,
            name: "홍대교동짬뽕",
            address: "서울 영등포구 선유로 34",
            phoneNumber: "02-2679-4559",
            category: "중식",
            price: 3333,
            type: 200
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1553978297-833d24d1b0d8?w=600&auto=format&fit=crop&q=60", // 김밥/분식
            latitude: 37.519032,
            longitude: 126.886547,
            name: "종로김밥 문래점",
            address: "서울 영등포구 선유로13길 25 에이스하이테크시티2",
            phoneNumber: "02-2257-8191",
            category: "분식",
            price: 94290,
            type: 300
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1547573854-74d2a71d0826?w=600&auto=format&fit=crop&q=60", // 설렁탕
            latitude: 37.518940,
            longitude: 126.886298,
            name: "본설렁탕 문래점",
            address: "서울 영등포구 선유로13길 25 117호",
            phoneNumber: "0507-1313-8110",
            category: "한식",
            price: 9867123467,
            type: 200
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1553978297-833d24d1b0d8?w=600&auto=format&fit=crop&q=60", // 분식
            latitude: 37.516329,
            longitude: 126.889686,
            name: "영일분식",
            address: "서울 영등포구 도림로141가길 34-1",
            phoneNumber: "02-2636-9817",
            category: "분식",
            price: 20000,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1529042410759-befb1204b468?w=600&auto=format&fit=crop&q=60", // 카츠/일식
            latitude: 37.517829,
            longitude: 126.887020,
            name: "문래동 훈카츠",
            address: "서울 영등포구 선유로9길 10 1층128호",
            phoneNumber: "02-2677-0225",
            category: "일식",
            price: 84438,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1529042410759-befb1204b468?w=600&auto=format&fit=crop&q=60", // 돈까스/경양식
            latitude: 37.516760,
            longitude: 126.889274,
            name: "문래동 돈까스",
            address: "서울 영등포구 도림로147길 2 문래동돈까스",
            phoneNumber: "0507-1390-1007",
            category: "경양식",
            price: 112376,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&auto=format&fit=crop&q=60", // 양식
            latitude: 37.516996,
            longitude: 126.888047,
            name: "선식당 문래점",
            address: "서울 영등포구 선유로 33 문래대림아파트101동 1층상가",
            phoneNumber: "0507-1391-0135",
            category: "양식",
            price: 16900,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1547573854-74d2a71d0826?w=600&auto=format&fit=crop&q=60", // 순대국
            latitude: 37.515690,
            longitude: 126.891630,
            name: "오복순대국",
            address: "서울 영등포구 도림로 465",
            phoneNumber: "0507-1408-4183",
            category: "한식",
            price: 38000,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=600&auto=format&fit=crop&q=60", // 국수
            latitude: 37.518829,
            longitude: 126.887853,
            name: "제주올래국수",
            address: "서울 영등포구 선유로11길 12 문래파라곤",
            phoneNumber: "02-2632-5677",
            category: "한식",
            price: 7612,
            type: 100
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1704890514547-b6b7d64086c1?w=600&auto=format&fit=crop&q=60", // 김치찌개
            latitude: 37.516829,
            longitude: 126.889325,
            name: "백채김치찌개 문래점",
            address: "서울 영등포구 도림로 489",
            phoneNumber: "02-2635-5206",
            category: "한식",
            price: 112358500,
            type: 200
        ),
        Restaurant(
            image: "https://images.unsplash.com/photo-1629127524579-269c62b90a96?w=600&auto=format&fit=crop&q=60", // 우동/일식
            latitude: 37.516857,
            longitude: 126.889075,
            name: "오타루소바우동",
            address: "서울 영등포구 도림로 491-2",
            phoneNumber: "02-2634-5460",
            category: "일식",
            price: 658,
            type: 300
        )
    ]
}
