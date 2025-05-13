package com.chaaraapp.henna.domain.model.posts.commentOfPost

import com.chaaraapp.henna.domain.model.posts.post.Comment
import kotlinx.serialization.Serializable

@Serializable
data class CommentsListModel(
    val comments: List<Comment>? = emptyList(),
    val content: String? = "",
    val description: String? = "",
    val id: Int? = -1,
    val type: String? = "",
    val user_id: Int? = -1
)