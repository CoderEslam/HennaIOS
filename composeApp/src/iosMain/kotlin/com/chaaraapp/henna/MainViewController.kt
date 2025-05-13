package com.chaaraapp.henna

import androidx.compose.ui.window.ComposeUIViewController
import com.chaaraapp.henna.components.arc.HalfCircleProgressSeekBar
import com.chaaraapp.henna.components.game.GameScreen
import com.chaaraapp.henna.domain.model.game.GameModel
import com.chaaraapp.henna.components.image.LoadImage
import com.chaaraapp.henna.components.pager.ViewPager
import com.chaaraapp.henna.components.post.PostContent
import com.chaaraapp.henna.components.spinner.Spinner
import com.chaaraapp.henna.domain.model.posts.post.PostModel
import com.chaaraapp.henna.components.appIcons.ChatIcon
import com.chaaraapp.henna.components.appIcons.GameIcon

fun MainViewController() = ComposeUIViewController { App() }

fun GameViewController(endGame: () -> Unit) = ComposeUIViewController {
    GameScreen(endGame = endGame)
}

fun PagerViewController(gameModelList: List<GameModel>, endGame: () -> Unit) =
    ComposeUIViewController {
        ViewPager(endGame = endGame, gameModelList = gameModelList)
    }


//Load image
fun LoadImage(image: String) = ComposeUIViewController { LoadImage(image = image) }


fun LoadPostContent(postModel: PostModel) =
    ComposeUIViewController { PostContent(postModel = postModel) }

fun <T> SpinnerView(
    items: List<T>,
    selectedItem: T,
    onItemSelected: (T) -> Unit,
    itemToString: (T) -> String = { it.toString() }
) = ComposeUIViewController {
    Spinner(
        items = items,
        selectedItem = selectedItem,
        onItemSelected = onItemSelected,
        itemToString = itemToString
    )
}

fun ArcProgress(progress: Float, onProgressChanged: (Float) -> Unit) = ComposeUIViewController {
    HalfCircleProgressSeekBar(
        progress = progress,
        onProgressChanged = { onProgressChanged(it) },
    )
}

//icons
fun ChatIcon(click: () -> Unit) = ComposeUIViewController { ChatIcon(click = click) }
fun GameIcon(click: () -> Unit) = ComposeUIViewController { GameIcon(click = click) }