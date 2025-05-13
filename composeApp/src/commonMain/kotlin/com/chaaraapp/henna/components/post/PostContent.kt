package com.chaaraapp.henna.components.post

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.chaaraapp.henna.components.image.LoadImage
import com.chaaraapp.henna.domain.model.mainHome.DataItemTypePosts
import com.chaaraapp.henna.domain.model.posts.post.PostModel
import com.chaaraapp.henna.utils.Constants


@Composable
fun PostContent(postModel: PostModel) {
    /*VideoPlayer(
        modifier = Modifier.fillMaxWidth().height(340.dp),
        url = "https://www.youtube.com/watch?v=AD2nEllUMJw", // Automatically Detect the URL, Wether to Play YouTube Video or .mp4 e.g
        autoPlay = true
    )*/
    Column {
        when (postModel.type) {
            DataItemTypePosts.TEXT.toString() -> {
                //
            }

            DataItemTypePosts.IMAGE.toString() -> {
                LoadImage(
                    image = Constants.PostContent + postModel.content
                )
            }

            DataItemTypePosts.VIDEO.toString() -> {

            }
        }
    }


}