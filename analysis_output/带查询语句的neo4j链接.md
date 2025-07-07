# 带查询语句的Neo4j链接

## Neo4j浏览器访问

- **Neo4j浏览器地址**: http://localhost:7474
- **用户名**: neo4j
- **密码**: kotei$88

## 快速查询链接

### 1. 查看所有函数

```cypher
MATCH (f:Function) RETURN f LIMIT 100
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=MATCH%20(f:Function)%20RETURN%20f%20LIMIT%20100

### 2. 查看所有变量

```cypher
MATCH (v:Variable) RETURN v LIMIT 100
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=MATCH%20(v:Variable)%20RETURN%20v%20LIMIT%20100

### 3. 查看所有脚本

```cypher
MATCH (s:Script) RETURN s LIMIT 100
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=MATCH%20(s:Script)%20RETURN%20s%20LIMIT%20100

### 4. 查看所有关系

```cypher
MATCH ()-[r]->() RETURN r LIMIT 100
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=MATCH%20()-[r]->()%20RETURN%20r%20LIMIT%20100

## 提交特定查询

### 提交: a2b3ad31 - Update GPT2 model implementation

#### Functions that call 'gpt2.model'

```cypher

        MATCH (caller:Function)-[:CALLS]->(target:Function {name: 'gpt2.model'})
        RETURN caller.name as caller_name, caller.file_path as caller_file
        ORDER BY caller.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28caller%3AFunction%29-%5B%3ACALLS%5D-%3E%28target%3AFunction%20%7Bname%3A%20%27gpt2.model%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20caller.name%20as%20caller_name%2C%20caller.file_path%20as%20caller_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20caller.name%0A%20%20%20%20%20%20%20%20

#### Variables used by 'gpt2.model'

```cypher

        MATCH (func:Function {name: 'gpt2.model'})-[:USES]->(var:Variable)
        RETURN var.name as variable_name, var.scope_id as scope
        ORDER BY var.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28func%3AFunction%20%7Bname%3A%20%27gpt2.model%27%7D%29-%5B%3AUSES%5D-%3E%28var%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20var.name%20as%20variable_name%2C%20var.scope_id%20as%20scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20var.name%0A%20%20%20%20%20%20%20%20

#### Variables defined by 'gpt2.model'

```cypher

        MATCH (func:Function {name: 'gpt2.model'})-[:DEFINES]->(var:Variable)
        RETURN var.name as variable_name, var.scope_id as scope
        ORDER BY var.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28func%3AFunction%20%7Bname%3A%20%27gpt2.model%27%7D%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20var.name%20as%20variable_name%2C%20var.scope_id%20as%20scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20var.name%0A%20%20%20%20%20%20%20%20

#### Impact chain analysis for 'gpt2.model'

```cypher

        MATCH path = (start:Function)-[:CALLS*1..3]->(target:Function {name: 'gpt2.model'})
        WITH path, start, target, length(path) as depth
        RETURN start.name as affected_function, depth, 
               [node in nodes(path) | node.name] as call_chain
        ORDER BY depth, start.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28start%3AFunction%29-%5B%3ACALLS%2A1..3%5D-%3E%28target%3AFunction%20%7Bname%3A%20%27gpt2.model%27%7D%29%0A%20%20%20%20%20%20%20%20WITH%20path%2C%20start%2C%20target%2C%20length%28path%29%20as%20depth%0A%20%20%20%20%20%20%20%20RETURN%20start.name%20as%20affected_function%2C%20depth%2C%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5Bnode%20in%20nodes%28path%29%20%7C%20node.name%5D%20as%20call_chain%0A%20%20%20%20%20%20%20%20ORDER%20BY%20depth%2C%20start.name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'X' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'X' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'X', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'X' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'X', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27X%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'X' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'X', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27X%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'pasts' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'pasts', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'pasts' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'pasts', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'pasts' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'pasts', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'pasts' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'pasts', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'parameters' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'parameters' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'parameters', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'parameters' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'parameters', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'parameters' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'parameters', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'hyperparameters' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'hyperparameters', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'hyperparameters' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'hyperparameters', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'hyperparameters' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'hyperparameters', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'hyperparameters' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'hyperparameters', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'weights' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'weights', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27weights%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'weights' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'weights', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27weights%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'weights' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'weights', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27weights%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'weights' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'weights', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27weights%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'seqLen' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'seqLen', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27seqLen%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'seqLen' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'seqLen', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27seqLen%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'seqLen' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'seqLen', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27seqLen%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'seqLen' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'seqLen', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27seqLen%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'h' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'h', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27h%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'h' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'h', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27h%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'h' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'h', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27h%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'h' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'h', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27h%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'positionOffset' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'positionOffset', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27positionOffset%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'positionOffset' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'positionOffset', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27positionOffset%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'positionOffset' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'positionOffset', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27positionOffset%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'positionOffset' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'positionOffset', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27positionOffset%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'presents' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'presents', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27presents%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'presents' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'presents', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27presents%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'presents' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'presents', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27presents%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'presents' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'presents', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27presents%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'layerName' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'layerName', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27layerName%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'layerName' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'layerName', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27layerName%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'layerName' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'layerName', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27layerName%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'layerName' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'layerName', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27layerName%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'logits' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'logits', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27logits%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'logits' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'logits', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27logits%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'logits' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'logits', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27logits%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'logits' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'logits', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27logits%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'pasts' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'pasts', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'pasts' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'pasts', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'pasts' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'pasts', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'pasts' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'pasts', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27pasts%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'parameters' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'parameters' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'parameters', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'parameters' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'parameters', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'parameters' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'parameters', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27parameters%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'Hyperparameters' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'Hyperparameters', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27Hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'Hyperparameters' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'Hyperparameters', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27Hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'Hyperparameters' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'Hyperparameters', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27Hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'Hyperparameters' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'Hyperparameters', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27Hyperparameters%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'Weights' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'Weights', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27Weights%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'Weights' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'Weights', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27Weights%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'Weights' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'Weights', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27Weights%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'Weights' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'Weights', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27Weights%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'NumLayers' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'NumLayers', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27NumLayers%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'NumLayers' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'NumLayers', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27NumLayers%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'NumLayers' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'NumLayers', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27NumLayers%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'NumLayers' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'NumLayers', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27NumLayers%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'present' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'present', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'present' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'present', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'present' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'present', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27present%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'present' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'present', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27present%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'gpt2' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'gpt2', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27gpt2%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'gpt2' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'gpt2', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27gpt2%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'gpt2' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'gpt2', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27gpt2%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'gpt2' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'gpt2', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27gpt2%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that use variable 'layer' in scope ''

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'layer', scope_id: ''})
        RETURN labels(user)[0] as user_type, user.name as user_name, user.file_path as user_file
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27layer%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%20user.file_path%20as%20user_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Functions/scripts that modify variable 'layer' in scope ''

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'layer', scope_id: ''})
        RETURN labels(modifier)[0] as modifier_type, modifier.name as modifier_name, modifier.file_path as modifier_file
        ORDER BY modifier_type, modifier_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27layer%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%2C%20modifier.file_path%20as%20modifier_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20modifier_type%2C%20modifier_name%0A%20%20%20%20%20%20%20%20

#### Variables assigned to 'layer' in scope ''

```cypher

        MATCH (source:Variable)-[:ASSIGNED_TO]->(target:Variable {name: 'layer', scope_id: ''})
        RETURN source.name as source_name, source.scope_id as source_scope
        ORDER BY source_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%20%7Bname%3A%20%27layer%27%2C%20scope_id%3A%20%27%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20source.name%20as%20source_name%2C%20source.scope_id%20as%20source_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20source_name%0A%20%20%20%20%20%20%20%20

#### Variables that 'layer' in scope '' is assigned to

```cypher

        MATCH (source:Variable {name: 'layer', scope_id: ''})-[:ASSIGNED_TO]->(target:Variable)
        RETURN target.name as target_name, target.scope_id as target_scope
        ORDER BY target_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28source%3AVariable%20%7Bname%3A%20%27layer%27%2C%20scope_id%3A%20%27%27%7D%29-%5B%3AASSIGNED_TO%5D-%3E%28target%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20target.name%20as%20target_name%2C%20target.scope_id%20as%20target_scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20target_name%0A%20%20%20%20%20%20%20%20

#### Scripts that call 'model'

```cypher

        MATCH (caller:Script)-[:CALLS]->(target:Script {name: 'model'})
        RETURN caller.name as caller_name, caller.file_path as caller_file
        ORDER BY caller_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28caller%3AScript%29-%5B%3ACALLS%5D-%3E%28target%3AScript%20%7Bname%3A%20%27model%27%7D%29%0A%20%20%20%20%20%20%20%20RETURN%20caller.name%20as%20caller_name%2C%20caller.file_path%20as%20caller_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20caller_name%0A%20%20%20%20%20%20%20%20

#### Functions called by 'model'

```cypher

        MATCH (script:Script {name: 'model'})-[:CALLS]->(func:Function)
        RETURN func.name as function_name, func.file_path as function_file
        ORDER BY func.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28script%3AScript%20%7Bname%3A%20%27model%27%7D%29-%5B%3ACALLS%5D-%3E%28func%3AFunction%29%0A%20%20%20%20%20%20%20%20RETURN%20func.name%20as%20function_name%2C%20func.file_path%20as%20function_file%0A%20%20%20%20%20%20%20%20ORDER%20BY%20func.name%0A%20%20%20%20%20%20%20%20

#### Variables used by 'model'

```cypher

        MATCH (script:Script {name: 'model'})-[:USES]->(var:Variable)
        RETURN var.name as variable_name, var.scope_id as scope
        ORDER BY var.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28script%3AScript%20%7Bname%3A%20%27model%27%7D%29-%5B%3AUSES%5D-%3E%28var%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20var.name%20as%20variable_name%2C%20var.scope_id%20as%20scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20var.name%0A%20%20%20%20%20%20%20%20

#### Variables defined by 'model'

```cypher

        MATCH (script:Script {name: 'model'})-[:DEFINES]->(var:Variable)
        RETURN var.name as variable_name, var.scope_id as scope
        ORDER BY var.name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28script%3AScript%20%7Bname%3A%20%27model%27%7D%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%29%0A%20%20%20%20%20%20%20%20RETURN%20var.name%20as%20variable_name%2C%20var.scope_id%20as%20scope%0A%20%20%20%20%20%20%20%20ORDER%20BY%20var.name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'pasts'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'pasts'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'layerName' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'layerName'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27layerName%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'layerName' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'layerName'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27layerName%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'presents' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'presents'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27presents%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'h' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'h'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27h%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'positionOffset' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'positionOffset'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27positionOffset%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'h' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'h'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27h%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'h' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'h'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27h%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'seqLen' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'seqLen'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27seqLen%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'weights' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'weights'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27weights%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'hyperparameters' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'hyperparameters'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27hyperparameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'parameters' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'parameters'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'pasts' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'pasts'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that use variable 'X' defined by 'gpt2.model'

```cypher

        MATCH (definer)-[:DEFINES]->(var:Variable {name: 'X'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(definer)[0] as definer_type, definer.name as definer_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28definer%29-%5B%3ADEFINES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28definer%29%5B0%5D%20as%20definer_type%2C%20definer.name%20as%20definer_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'X'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'X'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'X' by 'gpt2.layer.block'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'X'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'X' by 'gpt2.layer.block'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'X'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'X' by 'preprocessMiniBatch'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'X'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'X' by 'preprocessMiniBatch'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'X'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27X%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'pasts'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'pasts'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'pasts' by 'prepareInputs'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'pasts'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'parameters' by 'prepareInputs'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'parameters'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'weights'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'weights'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27weights%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'weights'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'weights'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27weights%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'presents' by 'gpt2.model'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'presents'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27presents%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'presents' by 'gpt2.model'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'presents'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27presents%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'logits' by 'gpt2.model'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'logits'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27logits%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'logits' by 'gpt2.model'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'logits'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27logits%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'pasts'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'pasts'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'pasts' by 'prepareInputs'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'pasts'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27pasts%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components that depend on usage of variable 'parameters'

```cypher

        MATCH (user)-[:USES]->(var:Variable {name: 'parameters'})
        MATCH path = (dependent)-[:CALLS*0..3]->(user)
        WHERE dependent <> user
        RETURN labels(dependent)[0] as dependent_type, dependent.name as dependent_name,
               length(path) as dependency_depth
        ORDER BY dependency_depth, dependent_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20path%20%3D%20%28dependent%29-%5B%3ACALLS%2A0..3%5D-%3E%28user%29%0A%20%20%20%20%20%20%20%20WHERE%20dependent%20%3C%3E%20user%0A%20%20%20%20%20%20%20%20RETURN%20labels%28dependent%29%5B0%5D%20as%20dependent_type%2C%20dependent.name%20as%20dependent_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20length%28path%29%20as%20dependency_depth%0A%20%20%20%20%20%20%20%20ORDER%20BY%20dependency_depth%2C%20dependent_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'parameters' by 'prepareInputs'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'parameters'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27parameters%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'present' by 'gpt2.layer.block'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'present'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'present' by 'gpt2.layer.block'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'present'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'present' by 'transformer.layer.attention'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'present'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'present' by 'transformer.layer.attention'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'present'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20

#### Components affected by modification of variable 'present' by 'transformer.layer.attention'

```cypher

        MATCH (modifier)-[:MODIFIES]->(var:Variable {name: 'present'})
        MATCH (user)-[:USES]->(var)
        RETURN labels(user)[0] as user_type, user.name as user_name,
               labels(modifier)[0] as modifier_type, modifier.name as modifier_name
        ORDER BY user_type, user_name
        
```

**直接链接**: http://localhost:7474/browser/?cmd=play&arg=%0A%20%20%20%20%20%20%20%20MATCH%20%28modifier%29-%5B%3AMODIFIES%5D-%3E%28var%3AVariable%20%7Bname%3A%20%27present%27%7D%29%0A%20%20%20%20%20%20%20%20MATCH%20%28user%29-%5B%3AUSES%5D-%3E%28var%29%0A%20%20%20%20%20%20%20%20RETURN%20labels%28user%29%5B0%5D%20as%20user_type%2C%20user.name%20as%20user_name%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20labels%28modifier%29%5B0%5D%20as%20modifier_type%2C%20modifier.name%20as%20modifier_name%0A%20%20%20%20%20%20%20%20ORDER%20BY%20user_type%2C%20user_name%0A%20%20%20%20%20%20%20%20


## 使用说明

1. 点击上述链接直接跳转到Neo4j浏览器
2. 链接会自动执行相应的查询语句
3. 可以在浏览器中修改查询语句进行进一步分析
4. 使用Neo4j浏览器的可视化功能查看图形结果

---
*生成时间: 2025-07-07 09:34:21*
