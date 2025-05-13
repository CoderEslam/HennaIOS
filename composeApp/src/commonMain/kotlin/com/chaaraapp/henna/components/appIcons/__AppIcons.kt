package com.chaaraapp.henna.components.appIcons

import androidx.compose.ui.graphics.vector.ImageVector
import com.chaaraapp.henna.components.appIcons.appicons.ArrowPlay
import com.chaaraapp.henna.components.appIcons.appicons.Chat
import com.chaaraapp.henna.components.appIcons.appicons.Game
import com.chaaraapp.henna.components.appIcons.appicons.Selected
import kotlin.collections.List as ____KtList

public object AppIcons

private var __AllIcons: ____KtList<ImageVector>? = null

public val AppIcons.AllIcons: ____KtList<ImageVector>
    get() {
        if (__AllIcons != null) {
            return __AllIcons!!
        }
        __AllIcons = listOf(Game, Chat, Selected, ArrowPlay)
        return __AllIcons!!
    }
