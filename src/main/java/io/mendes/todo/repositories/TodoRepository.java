package io.mendes.todo.repositories;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import io.mendes.todo.domains.Todo;

@Repository
public interface TodoRepository  extends PagingAndSortingRepository<Todo, Long>{

}