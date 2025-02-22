(defun c:CLEANBLOCKS ( / ss blk counter doc)
  (vl-load-com)
  (setq *min-length* 1.0) ; Minimum length in inches
  (setq counter 0) ; Counter for deleted items
  (setq doc (vla-get-activedocument (vlax-get-acad-object)))
  
  ;; Function to process a block definition
  (defun process-block (blk-name / blk-def)
    (princ (strcat "\nProcessing block: " blk-name))
    (setq blk-def (vla-item (vla-get-blocks doc) blk-name))
    
    ;; Process all entities in the block definition
    (vlax-for ent blk-def
      (setq obj-name (vla-get-objectname ent))
      (princ (strcat "\nFound entity: " obj-name))
      
      (cond
        ;; Process nested blocks
        ((= obj-name "AcDbBlockReference")
         (process-block (vla-get-name (vlax-vla-object->ename ent))))
        
        ;; Process lines
        ((and (= obj-name "AcDbLine")
             (< (vla-get-length ent) *min-length*))
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted short line"))
        
        ;; Process polylines
        ((and (= obj-name "AcDbPolyline")
             (< (vla-get-length ent) *min-length*))
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted short polyline"))
        
        ;; Process arcs
        ((and (= obj-name "AcDbArc")
             (< (vla-get-arclength ent) *min-length*))
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted short arc"))
        
        ;; Process circles
        ((and (= obj-name "AcDbCircle")
             (< (* (vla-get-radius ent) 2.0) *min-length*))
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted small circle"))
        
        ;; Delete all splines
        ((= obj-name "AcDbSpline")
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted spline"))
        
        ;; Delete all hatches
        ((= obj-name "AcDbHatch")
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted hatch"))
        
        ;; Delete all text
        ((or (= obj-name "AcDbText")
             (= obj-name "AcDbMText"))
         (vla-delete ent)
         (setq counter (1+ counter))
         (princ "\nDeleted text"))
      )
    )
  )

  ;; Function to update all block references
  (defun update-all-block-references ( / ss cnt blk)
    (setq ss (ssget "X" '((0 . "INSERT"))))
    (if ss
      (progn
        (setq cnt 0)
        (repeat (sslength ss)
          (setq blk (vlax-ename->vla-object (ssname ss cnt)))
          (vla-update blk)
          (setq cnt (1+ cnt))
        )
      )
    )
  )

  ;; Process all block references in the drawing
  (setq ss (ssget "X" '((0 . "INSERT"))))
  (if ss
    (progn
      (setq cnt 0)
      (repeat (sslength ss)
        (setq blk (ssname ss cnt))
        (setq blk-name (cdr (assoc 2 (entget blk))))
        (process-block blk-name)
        (setq cnt (1+ cnt))
      )
    )
  )

  ;; Also process all block definitions
  (vlax-for blk (vla-get-blocks doc)
    (if (and (= (vla-get-isxref blk) :vlax-false)
             (= (vla-get-islayout blk) :vlax-false))
      (process-block (vla-get-name blk))
    )
  )

  ;; Update all block references to show changes
  (vla-regen doc acallviewports)
  (update-all-block-references)
  (vla-regen doc acallviewports)
  
  (princ (strcat "\nBlocks cleaned successfully! Deleted " (itoa counter) " items."))
  (princ)
)
