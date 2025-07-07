-- 代码变更影响链路查询语句
-- 生成时间: 2025-07-07 09:34:21
-- 仓库: XCTianer/transformer-models

-- ========================================
-- 最完整的影响链路分析
-- ========================================

-- 最完整链路 1: model → Y
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_5
-- 严重程度: HIGH
-- 链路类型: function_call_chain
-- 路径长度: 2

-- 链路组件统计:
--   - 脚本: 1 个
--   - 函数: 1 个
--   - 变量: 1 个
--   - 总计: 3 个组件

-- 链路组件详情:
--   1. Script: model (文件: +gpt2/model.m)
--   2. Function: model (文件: FineTuneBERT.m)
--   3. Variable: Y (文件: FineTuneBERT.m)

-- 1. 查询完整链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
RETURN path;

-- 2. 查询链路上的所有节点（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
RETURN path;

-- 3. 查询链路上的脚本组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Script' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 4. 查询链路上的函数组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Function' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 5. 查询链路上的变量组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Variable' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 6. 查询链路上的所有关系（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 7. 查询链路关系详情（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 8. 查询链路完整图形（包含所有节点和关系）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes, relationships(path) as path_rels
UNWIND path_nodes as node
UNWIND path_rels as rel
RETURN startNode(rel) as source, rel as relationship, endNode(rel) as target;

-- 9. 查询链路节点的完整关系网络（推荐使用）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 10. 查询链路节点的2跳关系网络（最完整显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r1]-(m1)-[r2]-(m2)
WHERE n = node
RETURN n, r1, m1, r2, m2;

-- ============================================================

-- 最完整链路 2: model → bias
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_6
-- 严重程度: HIGH
-- 链路类型: function_call_chain
-- 路径长度: 2

-- 链路组件统计:
--   - 脚本: 1 个
--   - 函数: 1 个
--   - 变量: 1 个
--   - 总计: 3 个组件

-- 链路组件详情:
--   1. Script: model (文件: +gpt2/model.m)
--   2. Function: model (文件: FineTuneBERT.m)
--   3. Variable: bias (文件: FineTuneBERT.m)

-- 1. 查询完整链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
RETURN path;

-- 2. 查询链路上的所有节点（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
RETURN path;

-- 3. 查询链路上的脚本组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Script' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 4. 查询链路上的函数组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Function' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 5. 查询链路上的变量组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Variable' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 6. 查询链路上的所有关系（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 7. 查询链路关系详情（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 8. 查询链路完整图形（包含所有节点和关系）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes, relationships(path) as path_rels
UNWIND path_nodes as node
UNWIND path_rels as rel
RETURN startNode(rel) as source, rel as relationship, endNode(rel) as target;

-- 9. 查询链路节点的完整关系网络（推荐使用）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 10. 查询链路节点的2跳关系网络（最完整显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r1]-(m1)-[r2]-(m2)
WHERE n = node
RETURN n, r1, m1, r2, m2;

-- ============================================================

-- 最完整链路 3: model → dropout
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_7
-- 严重程度: HIGH
-- 链路类型: function_call_chain
-- 路径长度: 2

-- 链路组件统计:
--   - 脚本: 1 个
--   - 函数: 1 个
--   - 变量: 1 个
--   - 总计: 3 个组件

-- 链路组件详情:
--   1. Script: model (文件: +gpt2/model.m)
--   2. Function: model (文件: FineTuneBERT.m)
--   3. Variable: dropout (文件: FineTuneBERT.m)

-- 1. 查询完整链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
RETURN path;

-- 2. 查询链路上的所有节点（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
RETURN path;

-- 3. 查询链路上的脚本组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Script' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 4. 查询链路上的函数组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Function' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 5. 查询链路上的变量组件（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
WHERE 'Variable' IN labels(node)
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 6. 查询链路上的所有关系（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 7. 查询链路关系详情（完全展开图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 8. 查询链路完整图形（包含所有节点和关系）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes, relationships(path) as path_rels
UNWIND path_nodes as node
UNWIND path_rels as rel
RETURN startNode(rel) as source, rel as relationship, endNode(rel) as target;

-- 9. 查询链路节点的完整关系网络（推荐使用）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r]-(m)
WHERE n = node
RETURN n, r, m;

-- 10. 查询链路节点的2跳关系网络（最完整显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
WITH nodes(path) as path_nodes
UNWIND path_nodes as node
MATCH (n)-[r1]-(m1)-[r2]-(m2)
WHERE n = node
RETURN n, r1, m1, r2, m2;

-- ============================================================

-- ========================================
-- 其他影响链路查询
-- ========================================

-- 链路 1: gpt2.model → X
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_15
-- 严重程度: HIGH

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:352'
RETURN path;

-- ==================================================

-- 链路 2: gpt2.model → Y
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_16
-- 严重程度: HIGH

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:355'
RETURN path;

-- ==================================================

-- 链路 3: gpt2.model → bias
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_17
-- 严重程度: HIGH

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:357'
RETURN path;

-- ==================================================

-- 链路 4: gpt2.model → dropout
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_18
-- 严重程度: HIGH

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:354'
RETURN path;

-- ==================================================

-- 链路 5: gpt2.model → parameters
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_19
-- 严重程度: HIGH

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:353'
RETURN path;

-- ==================================================

-- 链路 9: gpt2.model → X
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_0
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:1562'
RETURN path;

-- ==================================================

-- 链路 10: gpt2.model → model
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_6
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:351'
RETURN path;

-- ==================================================

-- 链路 11: gpt2.model → pasts
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_9
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:3338'
RETURN path;

-- ==================================================

-- 链路 12: model → X
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2918_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2918'
RETURN path;

-- ==================================================

-- 链路 13: model → pasts
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2919_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2919'
RETURN path;

-- ==================================================

-- 链路 14: model → parameters
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2920_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2920'
RETURN path;

-- ==================================================

-- 链路 15: model → hyperparameters
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921_2
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921'
RETURN path;

-- ==================================================

-- 链路 16: model → weights
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922_2
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922'
RETURN path;

-- ==================================================

-- 链路 17: model → seqLen
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2923_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2923'
RETURN path;

-- ==================================================

-- 链路 18: model → h
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924_2
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 19: model → positionOffset
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2925_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2925'
RETURN path;

-- ==================================================

-- 链路 20: model → presents
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2926_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2926'
RETURN path;

-- ==================================================

-- 链路 21: model → layerName
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2927_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2927'
RETURN path;

-- ==================================================

-- 链路 22: model → logits
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2928_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2928'
RETURN path;

-- ==================================================

-- 链路 23: model → model
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_1
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:351'
RETURN path;

-- ==================================================

-- 链路 24: model → X
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_2
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2918'
RETURN path;

-- ==================================================

-- 链路 25: model → h
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_8
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 26: model → hyperparameters
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_9
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921'
RETURN path;

-- ==================================================

-- 链路 27: model → layerName
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_10
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2927'
RETURN path;

-- ==================================================

-- 链路 28: model → logits
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_11
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2928'
RETURN path;

-- ==================================================

-- 链路 29: model → parameters
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_12
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2920'
RETURN path;

-- ==================================================

-- 链路 30: model → pasts
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_15
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2919'
RETURN path;

-- ==================================================

-- 链路 31: model → positionOffset
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_17
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2925'
RETURN path;

-- ==================================================

-- 链路 32: model → presents
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_18
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2926'
RETURN path;

-- ==================================================

-- 链路 33: model → seqLen
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_19
-- 严重程度: MEDIUM

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2923'
RETURN path;

-- ==================================================

-- 链路 34: gpt2.model → h
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_2
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 35: gpt2.model → hyperparameters
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_3
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921'
RETURN path;

-- ==================================================

-- 链路 36: gpt2.model → layerName
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_4
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2927'
RETURN path;

-- ==================================================

-- 链路 37: gpt2.model → logits
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_5
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2928'
RETURN path;

-- ==================================================

-- 链路 38: gpt2.model → parameters
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_7
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2920'
RETURN path;

-- ==================================================

-- 链路 39: gpt2.model → positionOffset
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_11
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2925'
RETURN path;

-- ==================================================

-- 链路 40: gpt2.model → presents
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_12
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2926'
RETURN path;

-- ==================================================

-- 链路 41: gpt2.model → seqLen
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_13
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2923'
RETURN path;

-- ==================================================

-- 链路 42: gpt2.model → weights
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_14
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922'
RETURN path;

-- ==================================================

-- 链路 43: model → gpt2.model
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917'
RETURN path;

-- ==================================================

-- 链路 44: gpt2.model → X
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2918_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2918'
RETURN path;

-- ==================================================

-- 链路 45: gpt2.model → pasts
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2919_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2919'
RETURN path;

-- ==================================================

-- 链路 46: gpt2.model → parameters
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2920_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2920'
RETURN path;

-- ==================================================

-- 链路 47: gpt2.model → hyperparameters
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921'
RETURN path;

-- ==================================================

-- 链路 48: parameters → hyperparameters
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921_1
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2930' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2921'
RETURN path;

-- ==================================================

-- 链路 49: weights → h
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 50: gpt2.model → weights
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922'
RETURN path;

-- ==================================================

-- 链路 51: parameters → weights
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922_1
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2930' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922'
RETURN path;

-- ==================================================

-- 链路 52: gpt2.model → seqLen
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2923_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2923'
RETURN path;

-- ==================================================

-- 链路 53: gpt2.model → h
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 54: weights → h
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924_1
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2922' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 55: parameters → h
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924_3
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..8]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2930' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2924'
RETURN path;

-- ==================================================

-- 链路 56: gpt2.model → positionOffset
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2925_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2925'
RETURN path;

-- ==================================================

-- 链路 57: gpt2.model → presents
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2926_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2926'
RETURN path;

-- ==================================================

-- 链路 58: gpt2.model → layerName
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2927_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2927'
RETURN path;

-- ==================================================

-- 链路 59: gpt2.model → logits
-- 链路ID: upstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2928_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2928'
RETURN path;

-- ==================================================

-- 链路 60: model → gpt2.model
-- 链路ID: downstream_4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937_0
-- 严重程度: LOW

-- 查询链路路径（图形显示）
MATCH path = shortestPath((source)-[*1..7]->(target))
WHERE elementId(source) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2937' AND elementId(target) = '4:5d8fcd8a-64fe-4099-b6ee-02c601d1938d:2917'
RETURN path;

-- ==================================================

-- ========================================
-- 通用影响链查询语句（图形显示）
-- ========================================

-- 查询所有影响链（图形显示）
MATCH path = (source)-[r*1..5]->(target)
WHERE source <> target
RETURN path
ORDER BY length(path) DESC
LIMIT 10;

-- 查询包含脚本的影响链（图形显示）
MATCH path = (source)-[r*1..5]->(target)
WHERE source <> target AND ANY(node IN nodes(path) WHERE 'Script' IN labels(node))
RETURN path
ORDER BY length(path) DESC
LIMIT 5;

-- 查询包含函数的影响链（图形显示）
MATCH path = (source)-[r*1..5]->(target)
WHERE source <> target AND ANY(node IN nodes(path) WHERE 'Function' IN labels(node))
RETURN path
ORDER BY length(path) DESC
LIMIT 5;

-- 查询包含变量的影响链（图形显示）
MATCH path = (source)-[r*1..5]->(target)
WHERE source <> target AND ANY(node IN nodes(path) WHERE 'Variable' IN labels(node))
RETURN path
ORDER BY length(path) DESC
LIMIT 5;

-- 查询函数调用链（图形显示）
MATCH path = (source:Function)-[r:CALLS*1..3]->(target)
WHERE source <> target
RETURN path
ORDER BY length(path) DESC
LIMIT 5;

-- 查询变量依赖链（图形显示）
MATCH path = (source)-[r:DEFINES|USES*1..3]->(target)
WHERE source <> target
RETURN path
ORDER BY length(path) DESC
LIMIT 5;

-- 查询特定文件的影响（图形显示）
MATCH (n)-[r]-(m)
WHERE n.file_path CONTAINS 'getSupportFilePath.m' OR m.file_path CONTAINS 'getSupportFilePath.m'
RETURN n, r, m;

-- 查询特定文件节点的完整关系网络（推荐使用）
MATCH (n)
WHERE n.file_path CONTAINS 'getSupportFilePath.m'
MATCH (n)-[r]-(m)
RETURN n, r, m;

-- 查询所有Script节点的完整关系网络
MATCH (n:Script)-[r]-(m)
RETURN n, r, m
LIMIT 50;

-- 查询所有Function节点的完整关系网络
MATCH (n:Function)-[r]-(m)
RETURN n, r, m
LIMIT 50;

-- 查询所有Variable节点的完整关系网络（限制数量）
MATCH (n:Variable)-[r]-(m)
RETURN n, r, m
LIMIT 30;

-- 查询CALLS关系的完整网络
MATCH (n)-[r:CALLS]->(m)
RETURN n, r, m
LIMIT 30;

-- 查询DEFINES关系的完整网络
MATCH (n)-[r:DEFINES]->(m)
RETURN n, r, m
LIMIT 30;

-- 查询USES关系的完整网络
MATCH (n)-[r:USES]->(m)
RETURN n, r, m
LIMIT 30;

