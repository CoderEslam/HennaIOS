package com.chaaraapp.henna.domain.model.posts.commentOfPost

import kotlinx.serialization.Serializable

@Serializable
data class CommentsList(
    val `data`: CommentsListModel
)