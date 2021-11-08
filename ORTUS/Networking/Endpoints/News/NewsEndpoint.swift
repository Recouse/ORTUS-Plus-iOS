//
//  NewsEndpoint.swift
//  ORTUS
//
//  Created by Firdavs on 01/11/2021.
//  Copyright © 2021 Firdavs. All rights reserved.
//

extension Endpoint where Kind == EndpointKinds.Public, Response == ORTUS.Response<Articles> {
    static var publicNews: Self {
        Endpoint(
            host: .api,
            path: "mobile-api/v1/oauth/news",
            method: .post,
            parameters: buildParameters(for: .getPublicArticles)
        )
    }
}

extension Endpoint where Kind == EndpointKinds.Private, Response == ORTUS.Response<Articles> {
    static var news: Self {
        Endpoint(
            host: .api,
            path: "mobile-api/v1/oauth/news",
            method: .post,
            parameters: buildParameters(for: .getArticles)
        )
    }
}
