package com.chaaraapp.henna.components.appIcons

import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.chaaraapp.henna.components.appIcons.appicons.Chat
import com.chaaraapp.henna.components.appIcons.appicons.Game
import com.chaaraapp.henna.components.appIcons.appicons.Selected

@Composable
fun ChatIcon(click: () -> Unit) {
    Image(
        imageVector = AppIcons.Chat,
        contentDescription = "Chat",
        modifier = Modifier.size(30.dp).clickable(
            indication = null, // Removes ripple effect
            interactionSource = remember { MutableInteractionSource() },
            onClick = {
                click()
            }
        )
    )
}

@Composable
fun GameIcon(click: () -> Unit) {
    Image(
        imageVector = AppIcons.Game,
        contentDescription = "Game",
        modifier = Modifier.size(30.dp).clickable(
            indication = null, // Removes ripple effect
            interactionSource = remember { MutableInteractionSource() },
            onClick = {
                click()
            }
        )
    )
}

@Composable
fun SelectedIcon() {
    Image(
        imageVector = AppIcons.Selected,
        contentDescription = "Selected",
        modifier = Modifier
            .fillMaxWidth()
            .height(100.dp)
    )
}





