package com.chaaraapp.henna.domain.ts

import com.chaaraapp.henna.domain.model.categories.CategoryModel
import kotlinx.coroutines.Job

interface OnClickCategory {

    fun onClickCategory(categoryModel: CategoryModel) : Job

}