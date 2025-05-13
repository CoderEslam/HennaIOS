package com.chaaraapp.henna.components.pager

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.chaaraapp.henna.components.appIcons.SelectedIcon
import com.chaaraapp.henna.components.game.GameScreen
import com.chaaraapp.henna.components.image.LoadImage
import com.chaaraapp.henna.domain.model.game.GameModel
import com.chaaraapp.henna.utils.Constants
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


private const val TAG = "ViewPager"

@Composable
fun ViewPager(
    modifier: Modifier = Modifier,
    gameModelList: List<GameModel>,
    endGame: () -> Unit,
) {
    val pagerState = rememberPagerState(pageCount = { gameModelList.size })
    val coroutineScope = rememberCoroutineScope()

    HorizontalPager(
        state = pagerState,
        userScrollEnabled = false
    ) { pageIndex ->
        val selectedIndex = remember { mutableStateOf(ImageSelect.NOTHING) }
        val show = remember { mutableStateOf(GameOrSelect.LAYOUT) }

        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(rememberScrollState()),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            if (show.value == GameOrSelect.LAYOUT) {
                Text(
                    text = gameModelList[pageIndex].question ?: "",
                    modifier = Modifier.padding(horizontal = 16.dp),
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black
                )

                Spacer(modifier = Modifier.height(24.dp))

                Column(
                    verticalArrangement = Arrangement.Center,
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Box(contentAlignment = Alignment.BottomCenter) {
                        LoadImage(
                            modifier = Modifier
                                .clip(RoundedCornerShape(12.dp))
                                .fillMaxWidth()
                                .height(250.dp)
                                .clickable {
                                    selectedIndex.value = ImageSelect.TOP
                                }
                                .padding(4.dp),
                            image = Constants.QuestionImages + gameModelList[pageIndex].image_1
                        )
                        if (selectedIndex.value == ImageSelect.TOP) {
                            animate(visible = true)
                            LaunchedEffect(selectedIndex.value) {
                                delay(1000)
                                if (pageIndex == 0 || pageIndex == gameModelList.size - 1) {
                                    show.value = GameOrSelect.GAME
                                } else if (pageIndex < gameModelList.size - 1) {
                                    pagerState.animateScrollToPage(pageIndex + 1)
                                }
                            }
                        }
                    }
                    Box(contentAlignment = Alignment.BottomCenter) {
                        LoadImage(
                            modifier = Modifier
                                .clip(RoundedCornerShape(12.dp))
                                .fillMaxWidth()
                                .height(250.dp)
                                .clickable {
                                    selectedIndex.value = ImageSelect.BOTTOM
                                }
                                .padding(4.dp),
                            image = Constants.QuestionImages + gameModelList[pageIndex].image_2
                        )
                        if (selectedIndex.value == ImageSelect.BOTTOM) {
                            animate(visible = true)
                            LaunchedEffect(selectedIndex.value) {
                                delay(1000)
                                if (pageIndex == 0 || pageIndex == gameModelList.size - 1) {
                                    show.value = GameOrSelect.GAME
                                } else if (pageIndex < gameModelList.size - 1) {
                                    pagerState.animateScrollToPage(pageIndex + 1)
                                }
                            }
                        }
                    }
                }
                Spacer(modifier = Modifier.height(24.dp).weight(1f))
            } else if (pageIndex == 0 || pageIndex == gameModelList.size - 1) {
                AnimatedVisibility(visible = true) {
                    Column {
                        GameScreen(
                            endGame = {
                                coroutineScope.launch {
                                    show.value = GameOrSelect.LAYOUT
                                    if (pageIndex < gameModelList.size - 1) {
                                        pagerState.animateScrollToPage(pageIndex + 1)
                                    }
                                }
                                if (gameModelList.size - 1 == pageIndex) {
                                    endGame()
                                }
                            },
                        )
                    }
                }
            }
        }
    }
}


private fun <T> log(data: T) {
    println("$TAG , $data")
}


@Composable
fun animate(visible: Boolean) {
    AnimatedVisibility(visible) {
        SelectedIcon()
    }
}


enum class ImageSelect {
    NOTHING,
    TOP,
    BOTTOM
}

enum class GameOrSelect {
    GAME,
    LAYOUT
}