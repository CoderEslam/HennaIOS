package com.chaaraapp.henna.components.image

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun ErrorScreen(message: String? = null) {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .padding(all = 24.dp),
        contentAlignment = Alignment.Center
    ) {
        Text(text = message ?: "Empty", color = Color.Red)
    }
}