package com.chaaraapp.henna.components.spinner

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.DropdownMenu
import androidx.compose.material.DropdownMenuItem
import androidx.compose.material.OutlinedButton
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color

@Composable
fun <T> Spinner(
    items: List<T>,
    selectedItem: T,
    onItemSelected: (T) -> Unit,
    itemToString: (T) -> String = { it.toString() } // Default toString conversion
) {
    var expanded by remember { mutableStateOf(false) }

    Box(modifier = Modifier.fillMaxWidth()) {
        OutlinedButton(
            onClick = { expanded = true },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text(
                text = itemToString(selectedItem),
                color = Color.Black
            ) // Convert selected item to String
        }

        DropdownMenu(
            expanded = expanded,
            onDismissRequest = { expanded = false }
        ) {
            items.forEach { item ->
                DropdownMenuItem(
                    onClick = {
                        onItemSelected(item)
                        expanded = false
                    }
                ) {
                    Text(
                        text = itemToString(item),
                        color = Color.Black
                    ) // Convert each item to String
                }
            }
        }
    }
}

