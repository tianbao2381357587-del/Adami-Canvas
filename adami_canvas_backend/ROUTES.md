# Adami-Canvas 后端拆分说明

这版把原来的巨大 `main.py` 拆成：

- `main.py`：只负责启动服务。
- `adami_canvas_backend/server.py`：保留后的后端核心接口。
- `adami_canvas_backend/__init__.py`：导出 FastAPI app。

## 已删掉/下线的后端接口

- RunningHub：`/api/runninghub/*`
- 即梦 CLI：`/api/jimeng/*`
- 工作流：`/api/workflows/*`、`/api/canvas-workflows/*`、`/api/asset-library/workflows/*`
- 智能画布：`/api/smart-canvas/*`
- ComfyUI / ModelScope / 角度控制旧接口：`/api/comfyui/*`、`/api/ms/generate`、`/generate`、`/api/generate`、`/api/angle/*`
- 聊天与历史对话：`/api/chat*`、`/api/canvas-llm`、`/api/conversations/*`、`/api/history`
- 智能分类：`/api/local-assets/classify`、`/api/asset-library/items/classify`
- 自动更新：`/api/check-update`、`/api/update-*`

## 仍保留的核心能力

- 无限画布：项目、普通画布、新建、保存、回收站
- 素材库：资产库、分组、本地上传、画布资产、提示词库
- 火山引擎/方舟 API 设置：平台配置、API Key、视频模型
- 火山生成：`/api/online-image`、`/api/canvas-image-tasks`、`/api/canvas-video`

注意：为了避免误删导致启动失败，部分旧功能依赖的底层工具函数还保留；真正对外暴露的路由已经删除。
