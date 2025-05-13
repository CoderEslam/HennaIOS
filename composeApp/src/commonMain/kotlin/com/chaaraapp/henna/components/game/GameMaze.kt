package com.chaaraapp.henna.components.game

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.DrawScope
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.unit.dp
import com.chaaraapp.henna.components.appIcons.AppIcons
import com.chaaraapp.henna.components.appIcons.appicons.ArrowPlay
import com.chaaraapp.henna.themes.Yellow
import org.jetbrains.compose.ui.tooling.preview.Preview
import kotlin.random.Random

@Composable
fun GameScreen(
    endGame: () -> Unit,
    columns: Int = 7,
    rows: Int = 7
) {
    var mazeState = remember { mutableStateOf(generateMaze(columns, rows)) }
    var playerPosition = remember { mutableStateOf(mazeState.value[0][0]) }
    val cellSize = 150f // Set a fixed size for each cell, you can adjust as needed

    Column(
        modifier = Modifier
            .size(550.dp)
            .padding()
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.SpaceBetween,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Column(
            modifier = Modifier,
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Row(modifier = Modifier) {
                Spacer(modifier = Modifier.weight(1f))
                Canvas(modifier = Modifier
                    .size(350.dp)
                    .padding()
                    .pointerInput(Unit) {
                        detectTapGestures { offset ->
                            val direction =
                                determineDirection(playerPosition.value, offset, cellSize)
                            movePlayer(direction, playerPosition, mazeState.value)
                            if (playerPosition.value == mazeState.value[columns - 1][rows - 1]) {
                                endGame() // Trigger game event
                                // Regenerate maze or reset player position
                            }
                        }
                    }
                ) {
                    drawMaze(mazeState.value, cellSize)
                    drawPlayer(playerPosition.value, cellSize) {
                        endGame()
                    }
                }
                Spacer(modifier = Modifier.weight(1f))
            }
        }

        Spacer(modifier = Modifier.height(12.dp))

        Row(
            modifier = Modifier
                .size(150.dp)
                .clip(CircleShape)
                .background(color = Yellow)
                .padding(),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceAround
        ) {
            Image(
                imageVector = AppIcons.ArrowPlay,
                contentDescription = "",
                modifier = Modifier
                    .rotate(-90f)
                    .padding()
                    .size(30.dp)
                    .clickable {
                        movePlayer(Direction.LEFT, playerPosition, mazeState.value)
                    }
                    .padding()
            )
            Column(
                verticalArrangement = Arrangement.SpaceEvenly,
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Image(
                    imageVector = AppIcons.ArrowPlay,
                    contentDescription = "",
                    modifier = Modifier
                        .weight(1f)
                        .padding()
                        .size(30.dp)
                        .clickable {
                            movePlayer(Direction.UP, playerPosition, mazeState.value)
                        }
                        .padding()
                )
                Spacer(modifier = Modifier.weight(1f))
                Image(
                    imageVector = AppIcons.ArrowPlay,
                    contentDescription = "",
                    modifier = Modifier.weight(1f)
                        .rotate(180f)
                        .padding()
                        .size(30.dp)
                        .clickable {
                            movePlayer(Direction.DOWN, playerPosition, mazeState.value)
                        }
                        .padding()
                )
            }
            Image(
                imageVector = AppIcons.ArrowPlay,
                contentDescription = "",
                modifier = Modifier.rotate(90f)
                    .padding()
                    .size(30.dp)
                    .clickable {
                        movePlayer(Direction.RIGHT, playerPosition, mazeState.value)
                    }
                    .padding()
            )
        }
    }

}


fun DrawScope.drawMaze(cells: Array<Array<Cell>>, cellSize: Float) {
    cells.forEach { row ->
        row.forEach { cell ->
            val x = cell.column * cellSize
            val y = cell.row * cellSize

            // Draw walls based on cell's wall properties
            if (cell.topWall) drawLine(
                color = Color.Gray,
                start = Offset(x, y),
                end = Offset(x + cellSize, y),
                strokeWidth = WALL_THICKNESS
            )
            if (cell.leftWall) drawLine(
                color = Color.Gray,
                start = Offset(x, y),
                end = Offset(x, y + cellSize),
                strokeWidth = WALL_THICKNESS
            )
            if (cell.bottomWall) drawLine(
                color = Color.Gray,
                start = Offset(x, y + cellSize),
                end = Offset(x + cellSize, y + cellSize),
                strokeWidth = WALL_THICKNESS
            )
            if (cell.rightWall) drawLine(
                color = Color.Gray,
                start = Offset(x + cellSize, y),
                end = Offset(x + cellSize, y + cellSize),
                strokeWidth = WALL_THICKNESS
            )
        }
    }
}

fun DrawScope.drawPlayer(player: Cell, cellSize: Float, endGame: () -> Unit) {
    val x = player.column * cellSize
    val y = player.row * cellSize
    val margin = cellSize / 10
    val greenRectPosition = Offset(x + margin, y + margin)
    drawRect(
        color = Color.Green,
        topLeft = Offset(x + margin, y + margin),
        size = Size(cellSize - 2 * margin, cellSize - 2 * margin)
    )

    val redRectSize = Size(100f, 100f) // Size of the target rect
    val redRectPosition =
        Offset(size.width - 120f, size.height - 120f) // Fixed bottom-right position

    drawRect(
        color = Color.Red,
        topLeft = redRectPosition,
        size = redRectSize
    )
}

private fun determineDirection(player: Cell, tapOffset: Offset, cellSize: Float): Direction? {
    val playerCenterX = player.column * cellSize + cellSize / 2
    val playerCenterY = player.row * cellSize + cellSize / 2

    val dx = tapOffset.x - playerCenterX
    val dy = tapOffset.y - playerCenterY

    return when {
        dx > cellSize -> Direction.RIGHT
        dx < -cellSize -> Direction.LEFT
        dy > cellSize -> Direction.DOWN
        dy < -cellSize -> Direction.UP
        else -> null
    }
}

private fun movePlayer(
    direction: Direction?,
    playerPosition: MutableState<Cell>,
    cells: Array<Array<Cell>>
) {
    direction?.let {
        val player = playerPosition.value
        val (newColumn, newRow) = when (direction) {
            Direction.UP -> player.column to player.row - 1
            Direction.DOWN -> player.column to player.row + 1
            Direction.LEFT -> player.column - 1 to player.row
            Direction.RIGHT -> player.column + 1 to player.row
        }

        if (newColumn in cells.indices && newRow in cells[0].indices && !hasWall(
                player,
                direction
            )
        ) {
            playerPosition.value = cells[newColumn][newRow]
        }
    }
}

private fun hasWall(cell: Cell, direction: Direction): Boolean {
    return when (direction) {
        Direction.UP -> {
            cell.topWall
        }

        Direction.DOWN -> {
            cell.bottomWall
        }

        Direction.LEFT -> {
            cell.leftWall
        }

        Direction.RIGHT -> {
            cell.rightWall
        }
    }
}

private fun generateMaze(columns: Int, rows: Int): Array<Array<Cell>> {
    val maze = Array(columns) { x ->
        Array(rows) { y -> Cell(x, y) }
    }
    val stack = Stack<Cell>()
    var current: Cell? = maze[0][0]
    current?.visited = true

    do {
        val next = getNeighbour(current, maze)
        if (next != null) {
            removeWall(current, next)
            if (current != null) {
                stack.push(current)
            }
            current = next
            current.visited = true
        } else current = stack.pop()
    } while (stack.isNotEmpty())

    return maze
}

private fun getNeighbour(current: Cell?, cells: Array<Array<Cell>>): Cell? {
    val neighbours = mutableListOf<Cell>()

    current?.let {
        // left neighbour
        if (it.column > 0 && !cells[it.column - 1][it.row].visited) neighbours.add(cells[it.column - 1][it.row])
        // right neighbour
        if (it.column < cells.size - 1 && !cells[it.column + 1][it.row].visited) neighbours.add(
            cells[it.column + 1][it.row]
        )
        // top neighbour
        if (it.row > 0 && !cells[it.column][it.row - 1].visited) neighbours.add(cells[it.column][it.row - 1])
        // bottom neighbour
        if (it.row < cells[0].size - 1 && !cells[it.column][it.row + 1].visited) neighbours.add(
            cells[it.column][it.row + 1]
        )
    }

    return if (neighbours.isNotEmpty()) neighbours[Random.nextInt(neighbours.size)] else null
}

private fun removeWall(current: Cell?, next: Cell) {
    if (current != null) {
        when {
            current.column == next.column && current.row == next.row + 1 -> {
                current.topWall = false
                next.bottomWall = false
            }

            current.column == next.column && current.row == next.row - 1 -> {
                current.bottomWall = false
                next.topWall = false
            }

            current.column == next.column + 1 && current.row == next.row -> {
                current.leftWall = false
                next.rightWall = false
            }

            current.column == next.column - 1 && current.row == next.row -> {
                current.rightWall = false
                next.leftWall = false
            }
        }
    }
}

enum class Direction {
    UP, DOWN, LEFT, RIGHT
}

data class Cell(var column: Int, var row: Int) {
    var topWall = true
    var leftWall = true
    var rightWall = true
    var bottomWall = true
    var visited = false
}

const val WALL_THICKNESS = 10f

class Stack<E> {
    private val deque = ArrayDeque<E>()

    // Push an item onto the stack
    fun push(item: E) {
        deque.addFirst(item)
    }

    // Pop an item from the stack
    fun pop(): E? {
        return if (deque.isNotEmpty()) deque.removeFirst() else null
    }

    // Peek at the top item of the stack
    fun peek(): E? {
        return deque.firstOrNull()
    }

    // Check if the stack is empty
    fun empty(): Boolean {
        return deque.isEmpty()
    }

    // Check if the stack is not empty
    fun isNotEmpty(): Boolean {
        return deque.isNotEmpty()  // Using the isNotEmpty() function
    }

    // Search for an item in the stack (returns 1-based index or -1 if not found)
    fun search(item: E): Int {
        val index = deque.indexOf(item)
        return if (index != -1) deque.size - index else -1
    }
}

@Preview
@Composable
fun vG() {
    GameScreen(endGame = {

    })
}